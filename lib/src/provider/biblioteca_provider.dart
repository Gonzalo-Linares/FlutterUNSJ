import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

//Se genera de manera privada la clase
class _BibliotecaProvider {
  //Se genera una lista dinámica y se inicializa como una lista vacía
  List<dynamic> opciones = [];

  //Se define el constructor
  _BibliotecaProvider();

  //El método cargarData es un Future que permite devolver el listado de opciones una vez que se ha leído del archivo JSON
  //El Future va a retornar cuando esté disponible, la información en una lista dinámica
  Future<List<dynamic>> cargarData() async {
    final resp = await rootBundle.loadString('data/biblioteca.json');
    Map dataMap = json.decode(resp);
    opciones = dataMap['biblioteca'];

    return opciones;
  }
}

//Se crea la instancia del BibliotecaProvider
final bibliotecaProvider = _BibliotecaProvider();
