import 'package:flutter/material.dart';

abstract class AppTheme {
  // Configuración explícita del tema claro basado en la paleta de colores del logo
  static ThemeData get lightTheme {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        
        // Paleta de colores principal
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF0F123F),       // Azul Oscuro de la montaña
          onPrimary: Colors.white,
          secondary: Color(0xFFF7D070),     // Amarillo ocre del fondo
          onSecondary: Color(0xFF53241B),   // Marrón oscuro para contraste
          tertiary: Color(0xFF7E1315),      // Terracota / Rojo andino
          onTertiary: Colors.white,
          surface: Color(0xFFFFFFA2),       // Amarillo claro (Sol) para tarjetas/superficies
          onSurface: Color(0xFF0F123F),
          error: Color(0xFFB00020),
          onError: Colors.white,
        ),

        // Personalización de componentes
        scaffoldBackgroundColor: const Color(0xFFFFFFA2).withValues(alpha: 0.15), // Fondo
        
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F123F),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF7D070), // Botones en terracota
            foregroundColor: Colors.black,
          ),
        ),
      );
  }

  // Configuración explícita del tema oscuro basado en la paleta de colores del logo
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark, // Modo oscuro
  
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFF7D070),       // El Ocre del fondo ahora es el color primario (destaca en la oscuridad)
        onPrimary: Color(0xFF0F123F),     // Texto oscuro sobre el fondo ocre
        secondary: Color(0xFF7E1315),     // Terracota para elementos secundarios o acentos
        onSecondary: Colors.white,
        tertiary: Color(0xFFFFFFA2),      // Amarillo claro (Sol) para pequeños detalles o estados activos
        onTertiary: Color(0xFF0F123F),
        surface: Color(0xFF16194F),       // Un azul un poco más claro que el fondo para tarjetas (Cards) y diálogos
        onSurface: Colors.white,
        error: Color(0xFFCF6679),
        onError: Colors.black,
      ),

      // Fondo general de la app usando el azul oscuro del logo
      scaffoldBackgroundColor: const Color(0xFF0F123F),
  
      //  Todos los iconos por defecto usan el color primario del esquema
      iconTheme: const IconThemeData(
        color: Color(0xFFF7D070),
      ),
      // Configuración de la AppBar integrada con el fondo
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0F123F),
        foregroundColor: Color(0xFFF7D070), // Título en ocre
        elevation: 0,
      ),
  
      // Botones que resaltan en la oscuridad con el tono terracota
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF7D070),
          foregroundColor: Colors.black,
          shadowColor: Colors.black45,
        ),
      ),

    );
  }
}
