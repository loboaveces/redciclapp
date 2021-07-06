import 'dart:ui';

import 'package:flutter/material.dart';

class VerificaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
          title: Text(
            'Verifica tu cuenta antes de continuar',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            _fondoApp(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 220),
                  _verifica(),
                  SizedBox(
                    height: 45,
                  ),
                  _boton(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.white,
          Colors.grey[500],
        ],
        begin: FractionalOffset(0.0, 0.97),
        end: FractionalOffset(0.0, 0.99),
      )),
    );

    final logo = Image(
      image: AssetImage('assets/logoclean.png'),
      height: 100,
    );

    final fondo = Image(
      image: AssetImage('assets/icono-opaco.png'),
      height: 300,
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(top: 250, left: 130, child: fondo),
        Positioned(
          top: 20,
          left: 120,
          child: logo,
        ),
      ],
    );
  }
}

Widget _verifica() {
  return Center(
    child: Text(
      "Te enviamos un mensaje, debes ingresar a tu correo electrönico y verificar tu cuenta antes de continuar",
      textAlign: TextAlign.center,
      maxLines: 7,
      style: TextStyle(fontSize: 16.0),
    ),
  );
}

Widget _boton(BuildContext context) {
  return RaisedButton.icon(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    color: Colors.green,
    textColor: Colors.white,
    onPressed: () => Navigator.pushNamed(context, 'login'),
    icon: Icon(Icons.check),
    label: Text('ok, ya lo hice'),
  );
}
