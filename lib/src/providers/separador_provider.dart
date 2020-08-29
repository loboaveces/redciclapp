import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:redciclapp/src/models/separador_model.dart';

class CentroAcopioProvider {
  final String _url = 'https://redciclapp-60ddb.firebaseio.com/';
  // final _prefs = new PreferenciasUsuario();

  Future<bool> crearRevision(Separador revision) async {
    // final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/separadores.json';
    final resp = await http.post(url, body: separadorToJson(revision));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<List<Separador>> cargarSeparador() async {
    //final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/separadores.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<Separador> separador = new List();

    if (decodedData == null) return [];
    decodedData.forEach((id, rev) {
      final revTemp = Separador.fromJson(rev);
      revTemp.id = id;
      separador.add(revTemp);
    });
    print(separador);
    return separador;
  }
}
