import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

//Se genera de manera privada la clase
class _NovedadesProvider {
  //Se genera una lista dinámica y se inicializa como una lista vacía
  List<dynamic> novedades = [];

  //Se define el constructor
  _NovedadesProvider();

  //El método cargarData es un Future que permite devolver el listado de novedades una vez que se ha leído del archivo JSON
  //El Future va a retornar cuando esté disponible, la información en una lista dinámica
  Future<List<dynamic>> cargarData() async {
    final resp = await rootBundle.loadString('data/novedades.json');
    Map dataMap = json.decode(resp);
    novedades = dataMap['novedades'];

    return novedades;
  }
}

//Se crea la instancia del NovedadesProvider
final novedadesProvider = _NovedadesProvider();
