import 'dart:async';

// import 'package:autotes_sos_co19/src/preferencias_usuario/preferencias_usuario.dart';

class Validators {
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(email)) {
      sink.addError(email);
    } else {
      sink.addError('Email incorrecto');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(password)) {
      sink.add(password);
    } else {
      sink.addError('La contraseña no es válida');
    }
  });
}
