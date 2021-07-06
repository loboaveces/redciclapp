import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:redciclapp/src/utils/size_config.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';
import 'package:url_launcher/url_launcher.dart';

double _controlVertical = SizeConfig.devicePixelHeight;
double _controlHorizontal = SizeConfig.devicePixelWidth;
double _posicionLogo = _controlHorizontal / 10;
double _posicionFondo = _controlVertical / 5;

class AcercaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
          title: Text(
            'Acerca de Redcicla',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        drawer: MenuWidget(),
        body: Stack(
          children: <Widget>[
            _fondoApp(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 150),
                  _texto(),
                  _imagenytexto(),
                  _botonesRedondeados(context),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            )
            //_texto(),
          ],
        ),
        //bottomNavigationBar: _bottonNavigationBar(context)
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
        Positioned(top: _posicionFondo, left: _posicionLogo + 20, child: fondo),
        Positioned(
          top: 20,
          left: _posicionLogo,
          child: logo,
        ),
      ],
    );
  }

  Widget _texto() {
    return Card(
      borderOnForeground: true,
      shadowColor: Colors.green[900],
      elevation: 5,
      margin: EdgeInsets.all(15),
      color: Colors.green[100],
      child: Column(
        children: [
          Text(
            'REDcicla Bolivia se funda el 17 de mayo de 2017 y es una iniciativa ciudadana que funciona como una plataforma en red, que busca conectar a diferentes actores de la cadena de valor en torno al reciclaje. Priorizando y visibilizando el papel importante del reciclaje inclusivo, para generar una gestión integral de residuos.',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _imagenytexto() {
    return Container(
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/ciclo.jpg'),
            alignment: Alignment.center,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'Mira algunos videos sobre de los actores del ciclo del reciclaje: ',
            ),
          )
        ],
      ),
    );
  }

  Widget _botonesRedondeados(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado('Familias que separan', 'youtube.png', context,
              'https://www.youtube.com/watch?v=UEXPXCfENqk'),
          _crearBotonRedondeado('Familias que separan', 'youtube.png', context,
              'https://www.youtube.com/watch?v=NeGpHeleOd0'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado('Recicladoras de base', 'youtube.png', context,
              'https://www.youtube.com/watch?v=nH1tF9HwJ4o'),
          _crearBotonRedondeado('Eco-emprendimientos', 'youtube.png', context,
              'https://www.youtube.com/watch?v=2N_aG0O-Fs0'),
        ]),
      ],
    );
  }

  Widget _crearBotonRedondeado(
      String nombre, String imagen, BuildContext context, String ruta) {
    return GestureDetector(
      onTap: () {
        _launchURLPage(ruta);
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
                    fontSize: 15.0,
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

  _launchURLPage(String url) async {
    if (await canLaunch('$url')) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
