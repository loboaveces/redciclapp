import 'package:flutter/material.dart';

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Información incorrecta'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
