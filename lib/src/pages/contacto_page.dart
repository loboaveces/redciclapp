import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
          title: Text(
            'Contáctanos',
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
                  SizedBox(height: 220),
                  _botonesRedondeados(context),
                ],
              ),
            )
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
        Positioned(top: 250, left: 130, child: fondo),
        Positioned(
          top: 20,
          left: 120,
          child: logo,
        ),
      ],
    );
  }

  Widget _botonesRedondeados(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado(
              'Página \n de Facebook',
              'facebook.png',
              context,
              'https://www.facebook.com/REDcicla-Bolivia-117748492970580/'),
          _crearBotonRedondeado('Grupo \n de Facebook', 'group.png', context,
              'https://www.facebook.com/groups/2245402859114896/?ref=share'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado('Canal \n de Youtube', 'youtube2.png', context,
              'https://www.youtube.com/channel/UCPirO3q2m8qI3Q8GkFTUOog'),
          _crearBotonRedondeado2('Correo \n electrónico', 'gmail.png', context,
              'redciclabolivia@gmail.com'),
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

  Widget _crearBotonRedondeado2(
      String nombre, String imagen, BuildContext context, String ruta) {
    return GestureDetector(
      onTap: () {
        _launchURLmail(ruta);
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

  _launchURLPage(String url) async {
    if (await canLaunch('$url')) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchURLmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: '$email',
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
