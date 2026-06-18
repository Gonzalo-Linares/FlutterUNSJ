import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

//Se genera de manera privada la clase
class _TurnosProvider {
  //Se genera una lista dinámica y se inicializa como una lista vacía
  List<dynamic> turnos = [];

  //Se define el constructor
  _TurnosProvider();

  //El método cargarData es un Future que permite devolver el listado de turnos una vez que se ha leído del archivo JSON
  //El Future va a retornar cuando esté disponible, la información en una lista dinámica
  Future<List<dynamic>> cargarData() async {
    final resp = await rootBundle.loadString('data/turnos.json');
    Map dataMap = json.decode(resp);
    turnos = dataMap['turnos'];

    return turnos;
  }
}

//Se crea la instancia del TurnosProvider
final turnosProvider = _TurnosProvider();
