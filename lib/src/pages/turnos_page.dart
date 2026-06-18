import 'package:flutter/material.dart';
import '../widgets/main_layout.dart'; // Importa el layout base

class TurnosPage extends StatefulWidget {
  const TurnosPage({super.key});

  @override
  State<TurnosPage> createState() => _TurnosPageState();
}

class _TurnosPageState extends State<TurnosPage> {
  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      title: 'Turnos',
      body: Center(
        child: Text('¡Bienvenido a la página de turnos!'),
      ),
    );
  }
}