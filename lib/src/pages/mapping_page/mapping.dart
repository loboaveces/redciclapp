import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:redciclapp/src/pages/mapping_page/components/botones_redondeados.dart';
import 'package:redciclapp/src/pages/mapping_page/components/fondo_app.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';

class MappingPage extends StatelessWidget {
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
            fondoApp(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 220),
                  botonesRedondeados(context),
                ],
              ),
            )
          ],
        ),
        //bottomNavigationBar: _bottonNavigationBar(context)
      ),
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

}
