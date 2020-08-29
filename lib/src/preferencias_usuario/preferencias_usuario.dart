import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET del email
  get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  // GET y SET de la localidad
  get localidad {
    return _prefs.getString('localidad') ?? '';
  }

  set localidad(String value) {
    _prefs.setString('localidad', value);
  }
}
