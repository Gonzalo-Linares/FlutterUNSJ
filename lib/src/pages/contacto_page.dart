import 'package:flutter/material.dart';
import '../widgets/main_layout.dart'; // Importa el layout base

class ContactoPage extends StatefulWidget {
  const ContactoPage({super.key});

  @override
  State<ContactoPage> createState() => _ContactoPageState();
}

class _ContactoPageState extends State<ContactoPage> {
  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      title: 'Contacto',
      body: Center(
        child: Text('¡Bienvenido a la página de contacto!'),
      ),
    );
  }
}