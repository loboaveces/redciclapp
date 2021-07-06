import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:redciclapp/src/utils/size_config.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';

double _controlVertical = SizeConfig.devicePixelHeight;
double _controlHorizontal = SizeConfig.devicePixelWidth;
double _posicionLogo = _controlHorizontal / 10;
double _posicionFondo = _controlVertical / 5;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
          title: Text(
            'Mapeo de Datos',
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
        Positioned(top: _posicionFondo, left: _posicionLogo, child: fondo),
        Positioned(
          top: 20,
          left: _posicionLogo,
          child: logo,
        ),
      ],
    );
  }

  // Widget _bottonNavigationBar(BuildContext context) {
  //   return new Theme(
  //     data: Theme.of(context).copyWith(
  //       canvasColor: Color.fromRGBO(34, 181, 115, 1.0),
  //       primaryColor: Colors.white,
  //     ),
  //     child: BottomNavigationBar(items: [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home, size: 30.0),
  //         title: Container(
  //           child: new FlatButton(
  //               padding: EdgeInsets.all(0.0),
  //               onPressed: () {},
  //               //onPressed: () => Navigator.pushNamed(context, 'home'),
  //               child: null),
  //         ),
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.search, size: 30.0),
  //         title: Container(
  //           child: new FlatButton(
  //               padding: EdgeInsets.all(0.0),
  //               onPressed: () {},
  //               //onPressed: () => Navigator.pushNamed(context, 'inicio'),
  //               child: null),
  //         ),
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.exit_to_app, size: 30.0),
  //         title: Container(
  //           child: new FlatButton(
  //               padding: EdgeInsets.all(0.0), onPressed: () {}, child: null),
  //         ),
  //       ),
  //     ]),
  //   );
  // }

  Widget _botonesRedondeados(BuildContext context) {
    print('POSISCION LOGO: $_posicionLogo');
    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado('Recicladoras \n de base', 'residuos.png',
              context, 'recicladoras'),
          _crearBotonRedondeado(
              'Puntos \n de acopio', 'ubicacion.png', context, 'acopiadores'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado('Eco \nemprendimientos',
              'eco_emprendimiento.png', context, 'ecos'),
          _crearBotonRedondeado(
              'Acerca de \n Redcicla', 'icono.png', context, 'acercade'),
        ]),
      ],
    );
  }

  Widget _crearBotonRedondeado(
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
}
