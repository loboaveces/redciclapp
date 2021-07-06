import 'dart:convert';
// import 'dart:html';
//import 'dart:io';
//import 'package:mime_type/mime_type.dart';

import 'package:http/http.dart' as http;
//import 'package:http_parser/http_parser.dart';

import 'package:redciclapp/src/models/denuncia_model.dart';

class DenunciaProvider {
  final String _url = 'https://redciclapp-60ddb.firebaseio.com/';
  // final _prefs = new PreferenciasUsuario();

  Future<bool> crearDenuncia(Denuncia denuncia) async {
    // final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/denuncia.json';
    final resp = await http.post(url, body: denunciaToJson(denuncia));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<bool> editarDenuncia(Denuncia denuncia) async {
    // final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/denuncia/${denuncia.id}.json';
    final resp = await http.put(url, body: denunciaToJson(denuncia));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<List<Denuncia>> cargarDenuncia() async {
    //final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/denuncia.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<Denuncia> denuncia = new List();

    if (decodedData == null) return [];
    decodedData.forEach((id, rev) {
      final revTemp = Denuncia.fromJson(rev);
      revTemp.id = id;
      denuncia.add(revTemp);
    });
    print(denuncia);
    return denuncia;
  }

  Future<List<Denuncia>> cargar1Denuncia(Denuncia denuncia) async {
    //final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/denuncia/${denuncia.id}.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<Denuncia> denuncias = new List();

    if (decodedData == null) return [];
    decodedData.forEach((id, rev) {
      final revTemp = Denuncia.fromJson(rev);
      revTemp.id = id;
      denuncias.add(revTemp);
    });
    print(denuncias);
    return denuncias;
  }

  Future<int> borrarRegistro(String id) async {
    final url = '$_url/denuncias/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));

    return 1;
  }
}
