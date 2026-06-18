import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:controlturnos/src/theme/app_theme.dart';
import 'routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Club Andino Jáchal',
      
      // Configuración del Tema Basado en el Logo
      theme: AppTheme.lightTheme, 
      // Configuración del Tema Oscuro Basado en el Logo
      darkTheme: AppTheme.darkTheme, 
      // Cambio automático entre temas claro y oscuro según la configuración del sistema del usuario
      themeMode: ThemeMode.system, 
      // Definición de la ruta raiz 
      initialRoute: '/',
      // Mapa de rutas globales extraído de routes.dart
      routes: getApplicationRoutes(),
      
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('es', 'ES')],
    );
  }
}