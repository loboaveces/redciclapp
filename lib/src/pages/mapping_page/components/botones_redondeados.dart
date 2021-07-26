import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:redciclapp/src/utils/size_config.dart';

double _controlHorizontal = SizeConfig.devicePixelWidth;
double _posicionLogo = _controlHorizontal / 10;

Widget botonesRedondeados(BuildContext context) {
  print('POSISCION LOGO: $_posicionLogo');
  return Table(
    children: [
      TableRow(children: [
        crearBotonRedondeado(
            'Recicladoras \n de base', 'residuos.png', context, 'recicladoras'),
        crearBotonRedondeado(
            'Puntos \n de acopio', 'ubicacion.png', context, 'acopiadores'),
      ]),
      TableRow(children: [
        crearBotonRedondeado(
            'Eco \nemprendimientos', 'eco_emprendimiento.png', context, 'ecos'),
        crearBotonRedondeado(
            'Acerca de \n Redcicla', 'icono.png', context, 'acercade'),
      ]),
    ],
  );
}

Widget crearBotonRedondeado(
    String nombre, String imagen, BuildContext context, String ruta) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '$ruta');
    },
    child: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          height: 120.0,
          width: 100.0,
          margin: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(60, 89, 76, 0.15),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 5.0),
              Image(
                image: AssetImage('assets/$imagen'),
                height: 50,
                width: 50,
              ),
              Text(
                '$nombre',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
