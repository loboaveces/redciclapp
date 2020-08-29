import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:redciclapp/src/models/acopiador_model.dart';

class CentroAcopioProvider {
  final String _url = 'https://redciclapp-60ddb.firebaseio.com/';
  // final _prefs = new PreferenciasUsuario();

  Future<bool> crearRevision(Acopiador revision) async {
    // final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/acopiadores.json';
    final resp = await http.post(url, body: acopiadorToJson(revision));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<List<Acopiador>> cargarAcopiadores() async {
    //final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/acopiadores.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<Acopiador> acopiador = new List();

    if (decodedData == null) return [];
    decodedData.forEach((id, rev) {
      final revTemp = Acopiador.fromJson(rev);
      revTemp.id = id;
      acopiador.add(revTemp);
    });
    print(acopiador);
    return acopiador;
  }

  Future<String> subirimagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/redcicla-app/image/upload?upload_preset=lxswftl3');
    final mimeType = mime(imagen.path).split('/'); //image
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url,
    );

    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Error!!');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }
}
