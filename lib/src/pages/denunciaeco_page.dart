import 'package:flutter/services.dart';

//import 'package:redciclapp/src/models/acopiador_model.dart';
import 'package:redciclapp/src/models/denuncia_model.dart';
import 'package:redciclapp/src/models/ecoemprendimiento_model.dart';

//import 'package:redciclapp/src/models/ecoemprendimiento_model.dart';

import 'package:redciclapp/src/providers/denuncia_providers.dart';
//import 'package:redciclapp/src/providers/pedido_provider.dart';

import 'package:flutter/material.dart';
//import 'package:redciclapp/src/models/pedido_model.dart';
import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:redciclapp/src/providers/ecoemprendimiento_provider.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';
//import 'package:url_launcher/url_launcher.dart';

//

class DenunciaecoPage extends StatefulWidget {
  DenunciaecoPage({Key key}) : super(key: key);

  @override
  _DenunciaecoPageState createState() => _DenunciaecoPageState();
}

class _DenunciaecoPageState extends State<DenunciaecoPage> {
  final prefs = new PreferenciasUsuario();
  final formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final denunciaProvider = new DenunciaProvider();

  bool _guardando = false;
  final ecoemprendimientoProvider = new EcoemprendimientoProvider();

  Denuncia denuncia = new Denuncia();

  Ecoemprendimiento ecoemprendimiento = new Ecoemprendimiento();

  @override
  Widget build(BuildContext context) {
    final Ecoemprendimiento recData = ModalRoute.of(context).settings.arguments;
    Ecoemprendimiento ecoemprendimiento = recData;

    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
          title: Text('¿Por qué quieres reportar este registro?',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[]),
      drawer: MenuWidget(),
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(15.0),
              child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      _detalles(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _crearBoton(context, ecoemprendimiento),
                    ],
                  )))),
    );
  }

  Widget _detalles() {
    return TextFormField(
      initialValue: denuncia.detalles,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "Explica por qué",
        labelStyle: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
        icon: Icon(
          Icons.comment,
          color: Color.fromRGBO(34, 181, 115, 1.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
        ),
      ),
      onSaved: (value) => denuncia.detalles = value,
    );
  }

  Widget _crearBoton(
      BuildContext context, Ecoemprendimiento ecoemprendimiento) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Color.fromRGBO(34, 181, 115, 1.0),
      textColor: Colors.white,
      onPressed: () {
        if (_guardando == false) {
          _submit(context, ecoemprendimiento);
        }
      },
      icon: Icon(Icons.check),
      label: Text('Reportar'),
    );
  }

  void _submit(
      BuildContext context, Ecoemprendimiento ecoemprendimiento) async {
    // //Enviar mensaje whatsapp
    // initPlatformState();
    // FlutterOpenWhatsapp.sendSingleMessage("5917654321", "Hello");
    // Text('Running on: $_platformVersion\n');

    formkey.currentState.validate();
    formkey.currentState.save();
    denuncia.aquien = ecoemprendimiento.nombre;
    denuncia.correo2 = ecoemprendimiento.correo;
    denuncia.idobservado = ecoemprendimiento.id;
    denuncia.tipo = 'ecoemprendimiento';
    ecoemprendimiento.detalledenuncia = denuncia.detalles;
    ecoemprendimiento.tienedenuncia = 'Si';

    //Con esto vamos a permitir la edicion de entradas:
    setState(() {
      _guardando = true;
      ecoemprendimientoProvider.editarRevision(ecoemprendimiento);
    });
    denuncia.correo = prefs.email;
    denuncia.aquien = ecoemprendimiento.nombre;

    _mensajes(context);
    mostrarSnackbar("Se envió la denuncia correctamente");
    denuncia.fecha = DateTime.now().toString();

    if (denuncia.id == null) {
      denunciaProvider.crearDenuncia(denuncia);
    } else {
      denunciaProvider.editarDenuncia(denuncia);
    }

    setState(() {
      _guardando = false;
    });
  }

  void _mensajes(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Denuncia realizada'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'Gracias, tu denuncia fue registrada y sera enviada a los administradores para su revisión. '),
                Image(image: AssetImage('assets/registro.png')),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.pushNamed(context, 'inicio'),
              ),
            ],
          );
        });
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
        content: Text(mensaje), duration: Duration(milliseconds: 3000));
    scaffoldkey.currentState.showSnackBar(snackbar);
  }
}
