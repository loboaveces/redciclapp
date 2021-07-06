import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:autotes_sos_co19/src/preferencias_usuario/preferencias_usuario.dart';

class CurrentUser extends ChangeNotifier {
  //sacado de usuario Provider/

  String _uid;
  String _email;

  String get getUid => _uid;
  String get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartup() async {
    String retVal = 'error';
    try {
      User _firebaseUser = _auth.currentUser;
      _uid = _firebaseUser.uid;
      _email = _firebaseUser.email;
      retVal = 'success';
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signOut() async {
    String retVal = 'error';
    try {
      await _auth.signOut();
      _uid = null;
      _email = null;
      retVal = 'success';
      print(retVal);
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<bool> signUpUser(
    String email,
    String password,
  ) async {
    bool retVal = false;
    print(retVal);
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (_authResult.user != null) {
        retVal = true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }

    return retVal;
  }

  Future<bool> loginUser(String email, String password) async {
    bool retVal = false;
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_authResult.user != null) {
        _uid = _authResult.user.uid;
        _email = _authResult.user.email;

        retVal = true;
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<bool> sendPasswordResetMail(String email) async {
    bool retval = true;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return retval;
    } on FirebaseAuthException catch (e) {
      print(e);

      if (e.code == 'user-not-found') {
        print('Cuenta de correo no registrada');
        retval = false;
      } else {
        print('Mensaje de reseteo de cuenta enviado');
      }
    }
    return retval;
  }

  Future<bool> verifica(String email, String password) async {
    bool retVal = false;
    try {
      await _auth.signOut();
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (!_authResult.user.emailVerified) {
        await _authResult.user.sendEmailVerification();
      } else {
        retVal = true;
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
