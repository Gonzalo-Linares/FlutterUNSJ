import 'package:controlturnos/src/widgets/drawer.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final String title;
  final Widget body;

  const MainLayout({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: const CustomDrawer(), // Menú común
      body: body,
    );
  }
}