import 'package:flutter/material.dart';
import '../widgets/main_layout.dart'; // Importa el layout base

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      title: 'Inicio',
      body: Center(
        child: Text('¡Bienvenido al inicio de la App!'),
      ),
    );
  }
}