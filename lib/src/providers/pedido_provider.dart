import 'dart:convert';
// import 'dart:html';
//import 'dart:io';
//import 'package:mime_type/mime_type.dart';

import 'package:http/http.dart' as http;
//import 'package:http_parser/http_parser.dart';

import 'package:redciclapp/src/models/pedido_model.dart';

class PedidoProvider {
  final String _url = 'https://redciclapp-60ddb.firebaseio.com/';
  // final _prefs = new PreferenciasUsuario();

  Future<bool> crearPedido(Pedido pedido) async {
    // final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/pedidos.json';
    final resp = await http.post(url, body: pedidoToJson(pedido));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<bool> editarPedido(Pedido pedido) async {
    // final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/pedidos/${pedido.id}.json';
    final resp = await http.put(url, body: pedidoToJson(pedido));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<List<Pedido>> cargarPedido() async {
    //final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/pedidos.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<Pedido> pedido = new List();

    if (decodedData == null) return [];
    decodedData.forEach((id, rev) {
      final revTemp = Pedido.fromJson(rev);
      revTemp.id = id;
      pedido.add(revTemp);
    });
    print(pedido);
    return pedido;
  }

  Future<List<Pedido>> cargar1Pedido(Pedido pedido) async {
    //final url = '$_url/revisiones.json?auth=${_prefs.token}';
    final url = '$_url/pedidos/${pedido.id}.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<Pedido> pedidos = new List();

    if (decodedData == null) return [];
    decodedData.forEach((id, rev) {
      final revTemp = Pedido.fromJson(rev);
      revTemp.id = id;
      pedidos.add(revTemp);
    });
    print(pedidos);
    return pedidos;
  }

  Future<int> borrarRegistro(String id) async {
    final url = '$_url/pedidos/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));

    return 1;
  }
}
