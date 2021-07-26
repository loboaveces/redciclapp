import 'package:flutter/material.dart';
import 'package:redciclapp/src/utils/size_config.dart';

double _controlVertical = SizeConfig.devicePixelHeight;
double _controlHorizontal = SizeConfig.devicePixelWidth;
double _posicionLogo = _controlHorizontal / 10;
double _posicionFondo = _controlVertical / 5;

Widget fondoApp() {
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
      Positioned(top: _posicionFondo, left: _posicionLogo, child: fondo),
      Positioned(
        top: 20,
        left: _posicionLogo,
        child: logo,
      ),
    ],
  );
}
