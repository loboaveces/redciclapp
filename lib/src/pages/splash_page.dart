//Esta es la página inicial que se muestra en la aplicación.

import 'package:flutter/material.dart';
import 'package:redciclapp/src/utils/size_config.dart';

// Páginas a las que te manda esta página inicial
import 'package:redciclapp/src/pages/login_page.dart';
import 'package:redciclapp/src/pages/enrutador_page.dart';

class ScrollPage extends StatefulWidget {
  @override
  _ScrollPageState createState() => _ScrollPageState();
}

// Revisar esto
double _controlVertical = SizeConfig.devicePixelHeight;
//double _alturaTexto = 330;

class _ScrollPageState extends State<ScrollPage> {
  @override
  void initState() {
    super.initState();

    _revisariniciosesion().then((status) {
      if (status) {
        iraHome();
      } else {
        iraLogin();
      }
    });
  }

  // Verifica si el usuario está loggeado o no
  Future<bool> _revisariniciosesion() async {
    await Future.delayed(Duration(seconds: 3), () {});
    return true;
  }

  // Función que lleva a la página Home (Se usa cuando el usuario esta loggeado)
  void iraHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => RootPage()));
  }

  // Función que lleva a la página de inicio de sesión (Se usa cuando el usuario no está loggeado)
  void iraLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  //Diseño de la página:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        _splash(),
      ],
    ));
  }

  Widget _splash() {
    return Stack(
      children: <Widget>[
        _colordeFondo(),
        _imagenFondo(),
        _textos(),
      ],
    );
  }

  Widget _colordeFondo() {
    return Container(
      width: double.infinity,
      height: _controlVertical,
      color: Colors.white,
    );
  }

  Widget _imagenFondo() {
    return Container(
      width: double.infinity,
      height: _controlVertical,
      child: Image(
        image: AssetImage('assets/fondoapp2.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _textos() {
    // final estiloTexto = TextStyle(color: Colors.white, fontSize: 24.0);
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: 350),
          // Text("Te damos la bienvenida \n a Redcicla",
          //     textAlign: TextAlign.center, style: estiloTexto),
          Expanded(child: Container()),
          _crearloading(),
        ],
      ),
    );
  }

  Widget _crearloading() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Colors.white,
            )
          ],
        ),
        SizedBox(height: 15.0)
      ],
    );
  }
}
