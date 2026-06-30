import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/socio_model.dart';
import '../services/socio_service.dart';
import '../services/pagos_service.dart';
import '../widgets/main_layout.dart';
import '../widgets/pago/visor_comprobante.dart';
import '../widgets/pago/boton_confirmar_pago.dart';

class PagoPage extends StatefulWidget {
  const PagoPage({super.key});

  @override
  State<PagoPage> createState() => _PagoPageState();
}

class _PagoPageState extends State<PagoPage> {
  final SocioService _socioService = SocioService();
  final TextEditingController _dniController = TextEditingController();

  bool _subiendo = false;
  bool _buscandoSocio = false;
  String? _nombreArchivo;
  String? _tipoDetectado;
  String? _mensajeSocio;
  PlatformFile? _archivoSeleccionado;
  SocioModel? _socioEncontrado;

  Future<void> _seleccionarComprobante() async {
    // 1. Si es Web, salteamos el bloqueo de permisos nativos porque el navegador no los usa
    bool tienePermiso = kIsWeb;

    if (!kIsWeb) {
      // Si está corriendo en un celular (Android/iOS), ahí sí pedimos permiso
      final status = await Permission.storage.request();
      tienePermiso = status.isGranted;
    }

    if (tienePermiso) {
      final List<String> extensiones = ['jpg', 'jpeg', 'png', 'pdf'];

      final resultado = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: extensiones,
      );

      if (resultado != null && resultado.files.isNotEmpty) {
        final archivo = resultado.files.first;
        setState(() {
          _archivoSeleccionado = archivo;
          _nombreArchivo = archivo.name;
          _tipoDetectado = archivo.extension == 'pdf' ? 'pdf' : 'imagen';
        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Sin acceso al almacenamiento no podemos cargar el archivo.',
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  Future<void> _procesarPago() async {
    if (_socioEncontrado == null || _archivoSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Buscá un socio por DNI y seleccioná un comprobante.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _subiendo = true);

    try {
      await PagosService.instance.registrarComprobante(
        socioId: _socioEncontrado!.id ?? '',
        nombreSocio:
            '${_socioEncontrado!.nombre} ${_socioEncontrado!.apellido}',
        telefono: _socioEncontrado!.telefono,
        comprobanteUrl: 'mock/$_nombreArchivo',
        tipoArchivo: _tipoDetectado ?? 'archivo',
      );

      setState(() {
        _subiendo = false;
        _archivoSeleccionado = null;
        _nombreArchivo = null;
        _tipoDetectado = null;
        _socioEncontrado = null;
        _dniController.clear();
        _mensajeSocio = null;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '¡Comprobante enviado con éxito! Queda bajo revisión del Admin.',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() => _subiendo = false);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al enviar comprobante: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _dniController.dispose();
    super.dispose();
  }


  Future<void> _buscarSocioPorDni() async {
    final dni = _dniController.text.trim();

    if (dni.isEmpty) {
      setState(() {
        _socioEncontrado = null;
        _mensajeSocio = 'Ingresá un DNI para buscar.';
      });
      return;
    }

    setState(() {
      _buscandoSocio = true;
      _socioEncontrado = null;
      _mensajeSocio = null;
    });

    try {
      final socio = await _socioService.buscarSocioPorDni(dni);

      setState(() {
        _socioEncontrado = socio;
        _mensajeSocio = socio == null
            ? 'No se encontró un socio activo con ese DNI.'
            : 'Socio encontrado: ${socio.nombre} ${socio.apellido}';
      });
    } catch (e) {
      setState(() {
        _mensajeSocio = 'Error al buscar socio: $e';
      });
    } finally {
      setState(() {
        _buscandoSocio = false;
      });
    }
  }
  void _mostrarDialogoDeAjustes() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Permiso Requerido'),
        content: const Text(
          'Habilite el acceso al almacenamiento desde los ajustes del sistema.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Ir a Ajustes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Enviar Pago',
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            TextField(
              controller: _dniController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'DNI del socio',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge_outlined),
              ),
              onChanged: (_) {
                setState(() {
                  _socioEncontrado = null;
                  _mensajeSocio = null;
                });
              },
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _buscandoSocio ? null : _buscarSocioPorDni,
                icon: _buscandoSocio
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.search),
                label: Text(_buscandoSocio ? 'Buscando...' : 'Buscar socio'),
              ),
            ),

            if (_mensajeSocio != null) ...[
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: Icon(
                    _socioEncontrado == null
                        ? Icons.error_outline
                        : Icons.check_circle_outline,
                  ),
                  title: Text(_mensajeSocio!),
                  subtitle: _socioEncontrado == null
                      ? null
                      : Text(
                          'DNI: ${_socioEncontrado!.dni}'
                          '${_socioEncontrado!.telefono.isEmpty ? '' : ' - Tel: ${_socioEncontrado!.telefono}'}',
                        ),
                ),
              ),
            ],
            const SizedBox(height: 20),
            // 1. Invocación limpia al visor desacoplado
            VisorComprobante(
              nombreArchivo: _nombreArchivo,
              tipoDetectado: _tipoDetectado,
            ),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _subiendo || _socioEncontrado == null ? null : _seleccionarComprobante,
              icon: const Icon(Icons.folder_open_rounded),
              label: const Text('Seleccionar Archivo'),
            ),
            const Spacer(),

            // 2. Invocación limpia al botón desacoplado
            BotonConfirmarPago(
              subiendo: _subiendo,
              tieneArchivo: _archivoSeleccionado != null && _socioEncontrado != null,
              onConfirmar: _procesarPago,
            ),
          ],
        ),
      ),
    );
  }
}
