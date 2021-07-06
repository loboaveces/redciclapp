import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:redciclapp/src/models/ecoemprendimiento_model.dart';

class EcoemprendimientoProvider {
  final String _url = 'https://redciclapp-60ddb.firebaseio.com/';
  // final _prefs = new PreferenciasUsuario();

  Future<bool> crearRevision(Ecoemprendimiento revision) async {
    // final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/ecoemprendimientos.json';
    final resp = await http.post(url, body: ecoemprendimientoToJson(revision));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<bool> editarRevision(Ecoemprendimiento revision) async {
    // final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/ecoemprendimientos/${revision.id}.json';
    final resp = await http.put(url, body: ecoemprendimientoToJson(revision));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<List<Ecoemprendimiento>> cargarEmprendimiento() async {
    //final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/ecoemprendimientos.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<Ecoemprendimiento> emprendedor = new List();

    if (decodedData == null) return [];
    decodedData.forEach((id, rev) {
      final revTemp = Ecoemprendimiento.fromJson(rev);
      revTemp.id = id;
      emprendedor.add(revTemp);
    });
    print(emprendedor);
    return emprendedor;
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

  Future<int> borrarRegistro(String id) async {
    final url = '$_url/ecoemprendimientos/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));

    return 1;
  }
}
