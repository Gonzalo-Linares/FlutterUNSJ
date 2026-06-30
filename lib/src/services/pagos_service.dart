import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/pago.dart';

class PagosService {
  PagosService._internal();

  static final PagosService instance = PagosService._internal();

  final CollectionReference<Map<String, dynamic>> _pagosRef =
      FirebaseFirestore.instance.collection('pagos');

  Stream<List<Pago>> obtenerPagosStream() {
    return _pagosRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Pago.fromMap(
          doc.data(),
          documentId: doc.id,
        );
      }).toList();
    });
  }

  Future<List<Pago>> obtenerPagos() async {
    final snapshot = await _pagosRef.get();

    return snapshot.docs.map((doc) {
      return Pago.fromMap(
        doc.data(),
        documentId: doc.id,
      );
    }).toList();
  }

  Future<void> registrarComprobante({
    required String socioId,
    required String nombreSocio,
    required String telefono,
    required String comprobanteUrl,
    required String tipoArchivo,
    double monto = 0,
  }) async {
    final ahora = DateTime.now();

    await _pagosRef.add({
      'socioId': socioId,
      'nombreSocio': nombreSocio,
      'telefono': telefono,
      'mes': _nombreMes(ahora.month),
      'anio': ahora.year,
      'monto': monto,
      'estado': 'pendiente',
      'comprobanteUrl': comprobanteUrl,
      'fechaCarga': FieldValue.serverTimestamp(),
      'fechaRevision': null,
      'revisadoPor': '',
      'tipoArchivo': tipoArchivo,
    });
  }

  Future<void> aprobarPago(
    String pagoId, {
    String revisadoPor = '',
  }) async {
    await _actualizarEstadoPago(
      pagoId,
      estado: 'aprobado',
      revisadoPor: revisadoPor,
    );
  }

  Future<void> rechazarPago(
    String pagoId, {
    String revisadoPor = '',
  }) async {
    await _actualizarEstadoPago(
      pagoId,
      estado: 'rechazado',
      revisadoPor: revisadoPor,
    );
  }

  Future<void> _actualizarEstadoPago(
    String pagoId, {
    required String estado,
    required String revisadoPor,
  }) async {
    await _pagosRef.doc(pagoId).update({
      'estado': estado,
      'fechaRevision': FieldValue.serverTimestamp(),
      'revisadoPor': revisadoPor,
    });
  }

  String _nombreMes(int mes) {
    const meses = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];

    return meses[mes - 1];
  }
}