import 'package:flutter/services.dart';
import 'package:redciclapp/src/models/acopiador_model.dart';

import 'package:redciclapp/src/providers/pedido_provider.dart';

import 'package:flutter/material.dart';
import 'package:redciclapp/src/models/pedido_model.dart';
import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';
import 'package:url_launcher/url_launcher.dart';

//

class PedidosacoPage extends StatefulWidget {
  PedidosacoPage({Key key}) : super(key: key);

  @override
  _PedidosacoPageState createState() => _PedidosacoPageState();
}

class _PedidosacoPageState extends State<PedidosacoPage> {
  final prefs = new PreferenciasUsuario();
  Future<void> _launched;
  final formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final pedidoProvider = new PedidoProvider();
  bool _guardando = false;

  Pedido pedido = new Pedido();
  Acopiador acopiador = new Acopiador();

  @override
  Widget build(BuildContext context) {
    final Acopiador recData = ModalRoute.of(context).settings.arguments;

    Acopiador acopiador = recData;

    // final Pedido recData = ModalRoute.of(context).settings.arguments;
    // if (recData != null) {
    //   pedido = recData;
    // }

    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
          title: Text('¿Qué deseas entregar?',
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
                      _nombreCompleto(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _celular(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _queEntrega(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _diasDeLaSemana(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _horarios(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _detalles(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _crearBoton(context, acopiador),
                    ],
                  )))),
    );
  }

  Widget _celular() {
    return TextFormField(
      initialValue: pedido.celular,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "Tu nro de celular:",
        labelStyle: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
        hintText: "8 dígitos. Ej: 76543210.",
        helperText:
            "(No agregues +591)\nEsta información sólo será compartida con quién estás contactando",
        helperMaxLines: 3,
        icon: Icon(
          Icons.phone_android,
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
      onSaved: (value) => pedido.celular = value,
    );
  }

  Widget _nombreCompleto() {
    return TextFormField(
        initialValue: pedido.nombre,
        cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          labelText: "¿Cuál es tu nombre completo?",
          labelStyle: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
          helperText:
              "Esta información no será publicada, y sólo será compartida con quién estás contactando",
          helperMaxLines: 3,
          icon: Icon(
            Icons.account_circle,
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
        onSaved: (value) {
          pedido.nombre = value;
        });
  }

  Widget _horarios() {
    return TextFormField(
      initialValue: pedido.horarios,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "¿Cual sería el mejor horario de entrega? ",
        labelStyle: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
        icon: Icon(
          Icons.timer,
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
      onSaved: (value) => pedido.horarios = value,
    );
  }

  Widget _diasDeLaSemana() {
    return TextFormField(
      initialValue: pedido.fecha,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "¿Qué fecha? ",
        labelStyle: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
        icon: Icon(
          Icons.calendar_today,
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
      onSaved: (value) => pedido.fecha = value,
    );
  }

  Widget _queEntrega() {
    return TextFormField(
      initialValue: pedido.quecosas,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "¿Qué quieres entregar?",
        labelStyle: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
        icon: Icon(
          Icons.list,
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
      onSaved: (value) => pedido.quecosas = value,
    );
  }

  Widget _detalles() {
    return TextFormField(
      initialValue: pedido.detalles,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "Detalles o comentarios",
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
      onSaved: (value) => pedido.detalles = value,
    );
  }

  Widget _crearBoton(BuildContext context, Acopiador acopiador) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Color.fromRGBO(34, 181, 115, 1.0),
      textColor: Colors.white,
      onPressed: () {
        if (_guardando == false) {
          _submit(context, acopiador);
        }
      },
      icon: Icon(Icons.save),
      label: Text('Guardar'),
    );
  }

  void _submit(BuildContext context, Acopiador acopiador) async {
    // //Enviar mensaje whatsapp
    // initPlatformState();
    // FlutterOpenWhatsapp.sendSingleMessage("5917654321", "Hello");
    // Text('Running on: $_platformVersion\n');

    formkey.currentState.validate();
    formkey.currentState.save();
    pedido.aquien = acopiador.nombre;
    pedido.correo2 = acopiador.correo;
    pedido.tipo = 'acopiador';

    //Con esto vamos a permitir la edicion de entradas:
    setState(() {
      _guardando = true;
    });
    pedido.correo = prefs.email;
    pedido.actor = 'Punto de Acopio';

    _mensajes(context);
    mostrarSnackbar("Se envió el mensaje correctamente");
    pedido.fecha = DateTime.now().toString();

    if (pedido.id == null) {
      pedidoProvider.crearPedido(pedido);
    } else {
      pedidoProvider.editarPedido(pedido);
    }

    setState(() {
      _guardando = false;
    });
  }

  void _mensajes(BuildContext context) {
    String toLaunch =
        'https://wa.me/591${acopiador.celular}?text=Hola, solicitud de contacto a través de REDCICLA';
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Mensaje exitoso'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'Gracias, tu solicitud de contacto fue registrada. Pediremos que te contacten al nro de celular que escribiste. '),
                Image(image: AssetImage('assets/registro.png')),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok, ir a la página principal'),
                onPressed: () => Navigator.pushNamed(context, 'inicio'),
              ),
              FlatButton(
                child: Text('Contactar por Whatsapp ahora'),
                onPressed: () => setState(() {
                  _launched = _launchInWebViewOrVC(toLaunch);
                  print(_launched.toString());
                }),
              )
            ],
          );
        });
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
        content: Text(mensaje), duration: Duration(milliseconds: 3000));
    scaffoldkey.currentState.showSnackBar(snackbar);
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
