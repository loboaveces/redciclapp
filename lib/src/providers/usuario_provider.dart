import 'dart:convert';
import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyDILsA36nmiakQBwJ8KmuF1rQyZY_cqGxA';
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print('Esto imprime respuesta BD');
    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      _prefs.email = decodedResp['email'];
      return {
        'ok': true,
        'token': decodedResp['idToken'],
        'email': decodedResp['idToken']
      };
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> nuevousuario(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      _prefs.email = decodedResp['email'];
      return {
        'ok': true,
        'token': decodedResp['idToken'],
        'email': decodedResp['idToken']
      };
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}
