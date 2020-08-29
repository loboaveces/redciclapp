// import 'dart:async';
import 'dart:ui';
import 'package:redciclapp/src/pages/login_page.dart';
import 'package:redciclapp/src/pages/enrutador_page.dart';
import 'package:flutter/material.dart';

class ScrollPage extends StatefulWidget {
  @override
  _ScrollPageState createState() => _ScrollPageState();
}

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

  Future<bool> _revisariniciosesion() async {
    await Future.delayed(Duration(seconds: 3), () {});
    return true;
  }

  void iraHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => RootPage()));
  }

  void iraLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

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
      height: double.infinity,
      color: Colors.white,
    );
  }

  Widget _imagenFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
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
          SizedBox(height: 530.0),
          // Text("Te damos la bienvenida \n a Redcicla",
          //     textAlign: TextAlign.center, style: estiloTexto),
          Expanded(child: Container()),
          _crearloading(),
          SizedBox(height: 15.0),
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
