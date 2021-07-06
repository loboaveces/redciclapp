import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:redciclapp/src/states/current_user.dart';

final prefs = new PreferenciasUsuario();

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/intro.jpg'),
              fit: BoxFit.cover,
            )),
          ),
          ListTile(
            leading:
                Icon(Icons.pages, color: Color.fromRGBO(34, 181, 115, 1.0)),
            title: Text("Inicio"),
            onTap: () => Navigator.pushReplacementNamed(context, 'inicio'),
          ),
          ListTile(
            leading: Icon(Icons.map_outlined,
                color: Color.fromRGBO(34, 181, 115, 1.0)),
            title: Text("Mapear"),
            onTap: () => Navigator.pushReplacementNamed(context, 'home'),
          ),
          ListTile(
            leading:
                Icon(Icons.list_alt, color: Color.fromRGBO(34, 181, 115, 1.0)),
            title: Text("Mis registros"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'misregistros'),
          ),
          ListTile(
            leading:
                Icon(Icons.list_alt, color: Color.fromRGBO(34, 181, 115, 1.0)),
            title: Text("Mis solicitudes"),
            onTap: () => Navigator.pushReplacementNamed(context, 'solicitudes'),
          ),
          ListTile(
            leading: Icon(Icons.list, color: Color.fromRGBO(34, 181, 115, 1.0)),
            title: Text("Acerca de REDcicla"),
            onTap: () => Navigator.pushReplacementNamed(context, 'acercade'),
          ),
          ListTile(
            leading:
                Icon(Icons.phone, color: Color.fromRGBO(34, 181, 115, 1.0)),
            title: Text("Contáctanos"),
            onTap: () => Navigator.pushReplacementNamed(context, 'contacto'),
          ),
          ListTile(
            leading: Icon(Icons.book, color: Color.fromRGBO(34, 181, 115, 1.0)),
            title: Text("Normativa Ambiental"),
            onTap: () => Navigator.pushReplacementNamed(context, 'normativa'),
          ),
          ListTile(
            leading:
                Icon(Icons.person, color: Color.fromRGBO(34, 181, 115, 1.0)),
            title: Text("Administradores"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'aprobaciones'),
          ),
          ListTile(
              leading: Icon(Icons.exit_to_app,
                  color: Color.fromRGBO(34, 181, 115, 1.0)),
              title: Text("Cerrar Sesión"),
              onTap: () => _mensajecerrarsesion(context)),
          ListTile(
              leading: Icon(Icons.close_rounded,
                  color: Color.fromRGBO(34, 181, 115, 1.0)),
              title: Text("Cerrar Applicación"),
              onTap: () => _mensajesalirapp(context)),
        ],
      ),
    );
  }

  void _mensajesalirapp(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Cerrar la applicación'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('¿Quieres cerrar la aplicación?'),
                Image(image: AssetImage('assets/registro.png')),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Si'),
                onPressed: () => exit(0),
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.pushNamed(context, 'inicio'),
              )
            ],
          );
        });
  }

  void _mensajecerrarsesion(BuildContext context) {
    CurrentUser _currentUser = Provider.of(context, listen: false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Cerrar sesión'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('¿Quieres cerrar sesión de tu cuenta?'),
                Image(image: AssetImage('assets/registro.png')),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Si'),
                  onPressed: () {
                    _currentUser.signOut();
                    Navigator.pushNamed(context, 'splash');
                  }),
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.pushNamed(context, 'inicio'),
              )
            ],
          );
        });
  }
}
