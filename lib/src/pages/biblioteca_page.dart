import 'package:flutter/material.dart';
import '../widgets/main_layout.dart'; // Importa el layout base

class BibliotecaPage extends StatefulWidget {
  const BibliotecaPage({super.key});

  @override
  State<BibliotecaPage> createState() => _BibliotecaPageState();
}

class _BibliotecaPageState extends State<BibliotecaPage> {
  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      title: 'Biblioteca',
      body: Center(
        child: Text('¡Bienvenido a la página de biblioteca!'),
      ),
    );
  }
}