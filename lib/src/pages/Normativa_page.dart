import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class NormativaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
          title: Text(
            'Normativa ambiental',
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
              'Ley del Medio \n Ambiente Nro 1333',
              'pdf.png',
              context,
              'https://drive.google.com/file/d/1VDkzMxTpIfwIw13TlHu5Zab5LORjTI8D/view?usp=sharing'),
          _crearBotonRedondeado(
              'Ley de Gestión \n de Residuos Nro 755',
              'pdf.png',
              context,
              'https://drive.google.com/file/d/16GcVautAT_syeyWHSVo0Xeezzl_sugtr/view?usp=sharing'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(
              'Ley marco de  \n de madre tierra \ny desarrollo integral',
              'pdf.png',
              context,
              'https://drive.google.com/file/d/1PJF9BgEfo0vsP-2vlRsN6juff3AMGPeC/view?usp=sharing'),
          _crearBotonRedondeado(
              'Reglamento de \n Ley Nro 1333',
              'pdf.png',
              context,
              'https://drive.google.com/file/d/1_x_LLhN7mcdSXu75zKBMczPSCyR9rvTs/view?usp=sharing'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(
              'Decreto Supremo  \n Nro 2954',
              'pdf.png',
              context,
              'https://drive.google.com/file/d/1b-HHhd9VT2uQjJJaIEXdlIQIROA_ellh/view?usp=sharing'),
          _crearBotonRedondeado(
              'Reglamento de \n Ley Nro 755',
              'pdf.png',
              context,
              'https://drive.google.com/file/d/1fTn9PyPim17cEc0xApZsWjJyXQQ3eb5w/view?usp=sharing'),
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

  _launchURLPage(String url) async {
    if (await canLaunch('$url')) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
