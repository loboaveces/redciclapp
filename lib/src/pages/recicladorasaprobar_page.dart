// import 'dart:html';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:redciclapp/src/providers/recicladora_provider.dart';
import 'package:redciclapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:redciclapp/src/models/recicladora_model.dart';
import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';
//

class Recicladora2Page extends StatefulWidget {
  Recicladora2Page({Key key}) : super(key: key);

  @override
  _Recicladora2PageState createState() => _Recicladora2PageState();
}

// class RecicladoraPage extends StatefulWidget {
//   @override
//   // _RecicladoraPage createState() => _RecicladoraState();
// }

class _Recicladora2PageState extends State<Recicladora2Page> {
  final prefs = new PreferenciasUsuario();

  List<String> _localidades = [
    'Elegir Ciudad',
    // 'Beni',
    //'Cochabamba',
    'El Alto',
    'La Paz',
    // 'Oruro',
    // 'Pando',
    // 'Potosí',
    //'Santa Cruz',
    // 'Sucre',
    //'Tarija',
  ];
  String _opcionSeleccionada = 'Elegir Ciudad';

  // bool _guardando = false;

  List<String> _zonasLpz = [
    'Elegir Zona',
    'Achumani',
    'Alto obrajes',
    'Bella vista',
    'Bolognia',
    'Calacoto',
    'Centro',
    'Cota Cota',
    'Cotahuma',
    'Cristo Rey',
    'El Rosario',
    'Garita de Lima',
    'Irpavi',
    'La Florida',
    'Llojeta',
    'Los Pinos',
    'Miraflores',
    'Obrajes',
    'San Jorge',
    'San Miguel',
    'San Pedro',
    'Seguencoma',
    'Sopocachi',
    'Tembladerani',
    'Villa Armonía',
    'Villa Copacabana',
    'Villa Fátima',
    'Villa San Antonio',
    'Vino tinto',
    'Otras',
  ];
  String _zonaElegida = 'Elegir Zona';

  List<String> _denuncias = [
    'Si',
    'No',
  ];
  String _denuncia = '';

  File foto;

  final formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final recicladoraProvider = new RecicladoraProvider();
  bool _guardando = false;

  //Modelo de Recicladora, la creación de la recicladora
  Recicladora recicladora = new Recicladora();

  @override
  Widget build(BuildContext context) {
    final Recicladora recData = ModalRoute.of(context).settings.arguments;
    if (recData != null) {
      recicladora = recData;
    }

    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
          title: Text('Añadir Reciclador/a',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _seleccionarFoto,
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _tomarFoto,
            ),
          ]),
      drawer: MenuWidget(),
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(15.0),
              child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _mostrarFoto(),
                      _nombreCompleto(),
                      SizedBox(
                        height: 30.0,
                      ),
                      // Text(
                      //   'Ciudad donde recolecta:',
                      //   textAlign: TextAlign.left,
                      //   style: TextStyle(
                      //       color: Color.fromRGBO(34, 181, 115, 1.0),
                      //       fontSize: 16.0),
                      // ),
                      _elegirdepartamento(),
                      SizedBox(
                        height: 30.0,
                      ),
//horarios
// dias de la semana
                      _elegirzona(),

                      SizedBox(
                        height: 30.0,
                      ),
                      _celular(),
                      SizedBox(
                        height: 30.0,
                      ),
                      // _provincia(),
                      // SizedBox(
                      //   height: 30.0,
                      // ),
                      _queRecolecta(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _ruta(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _horarios(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _diasDeLaSemana(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _detalles(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _tienedenuncia(recicladora),
                      SizedBox(
                        height: 30.0,
                      ),
                      _crearBoton(context),
                    ],
                  )))),
    );
  }

  Widget _celular() {
    return TextFormField(
      initialValue: recicladora.celular,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "Nro de celular:",
        labelStyle: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
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
      onSaved: (value) => recicladora.celular = value,
    );
  }

  Widget _nombreCompleto() {
    return TextFormField(
      initialValue: recicladora.nombre,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "Nombre del reciclador/a ",
        labelStyle: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
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
      onSaved: (value) => recicladora.nombre = value,
    );
  }

  Widget _horarios() {
    return TextFormField(
      initialValue: recicladora.horarios,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "¿En que horarios recolecta? ",
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
      onSaved: (value) => recicladora.horarios = value,
    );
  }

  Widget _diasDeLaSemana() {
    return TextFormField(
      initialValue: recicladora.dias,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "¿Qué días de la semana recorre su ruta? ",
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
      onSaved: (value) => recicladora.dias = value,
    );
  }

  Widget _queRecolecta() {
    return TextFormField(
      initialValue: recicladora.recolecta,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "¿Que residuos recolecta?",
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
      onSaved: (value) => recicladora.recolecta = value,
    );
  }

  Widget _ruta() {
    return TextFormField(
      initialValue: recicladora.ruta,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "Calles que recorre:",
        labelStyle: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
        icon: Icon(
          Icons.location_on,
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
      onSaved: (value) => recicladora.ruta = value,
    );
  }

  Widget _tienedenuncia(Recicladora recicladora) {
    return Row(
      children: <Widget>[
        Icon(Icons.check_box, color: Colors.black),
        SizedBox(width: 30.0),
        Text('¿El registro fue reportado?  '),
        Expanded(
          child: DropdownButton(
            value: recicladora.tienedenuncia,
            style: TextStyle(
              color: Color.fromRGBO(34, 181, 115, 1.0),
            ),
            items: getOpcionesDropDown4(),
            onChanged: (opt) {
              setState(() {
                _denuncia = opt;
                recicladora.tienedenuncia = _denuncia;
              });
            },
          ),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown4() {
    List<DropdownMenuItem<String>> lista = new List();
    _denuncias.forEach((est) {
      lista.add(DropdownMenuItem(
        child: Text(est),
        value: est,
      ));
    });
    return lista;
  }

  // Widget _zona() {
  //   return TextFormField(
  //     initialValue: recicladora.zona,
  //     cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
  //     textCapitalization: TextCapitalization.sentences,
  //     decoration: InputDecoration(
  //       contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
  //       labelText: "¿Qué zona recorre?",
  //       labelStyle: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
  //       icon: Icon(
  //         Icons.location_city,
  //         color: Color.fromRGBO(34, 181, 115, 1.0),
  //       ),
  //       enabledBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
  //       ),
  //       focusedBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
  //       ),
  //       border: UnderlineInputBorder(
  //         borderSide: BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
  //       ),
  //     ),
  //     onSaved: (value) => recicladora.zona = value,
  //   );
  // }

  Widget _detalles() {
    return TextFormField(
      initialValue: recicladora.detalles,
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
      onSaved: (value) => recicladora.detalles = value,
    );
  }

  Widget _elegirdepartamento() {
    return Row(
      children: <Widget>[
        Icon(Icons.place, color: Color.fromRGBO(34, 181, 115, 1.0)),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: recicladora.departamento,
            style: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
            items: getOpcionesDropDown(),
            onChanged: (opt) {
              setState(() {
                _opcionSeleccionada = opt;
                recicladora.departamento = _opcionSeleccionada;
              });
            },
          ),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown() {
    List<DropdownMenuItem<String>> lista = new List();
    _localidades.forEach((depto) {
      lista.add(DropdownMenuItem(
        child: Text(depto),
        value: depto,
      ));
    });

    return lista;
  }

  Widget _elegirzona() {
    return Row(
      children: <Widget>[
        Icon(Icons.location_city, color: Color.fromRGBO(34, 181, 115, 1.0)),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: recicladora.zona,
            style: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
            items: getOpcionesDropDownZ(),
            onChanged: (opt) {
              if (_zonaElegida == "otra") {
                _zona();
              } else {
                setState(() {
                  _zonaElegida = opt;
                  recicladora.zona = _zonaElegida;
                });
              }
            },
          ),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDownZ() {
    List<DropdownMenuItem<String>> lista = new List();
    _zonasLpz.forEach((zona) {
      lista.add(DropdownMenuItem(
        child: Text(zona),
        value: zona,
      ));
    });

    return lista;
  }

  Widget _zona() {
    return TextFormField(
      initialValue: recicladora.zona,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          labelText: "¿Qué zona es?"),
      onSaved: (value) => recicladora.zona = value,
    );
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Color.fromRGBO(34, 181, 115, 1.0),
      textColor: Colors.white,
      onPressed: () {
        if (_guardando == false) {
          _submit(context);
        }
      },
      icon: Icon(Icons.save),
      label: Text('Guardar'),
    );
  }

  void _submit(BuildContext context) async {
    if (_opcionSeleccionada != 'Elegir') {
      formkey.currentState.validate();
      formkey.currentState.save();
      //Con esto vamos a permitir la edicion de entradas:

      //Para controlar los registros reportados
      recicladora.tienedenuncia = 'No';
      recicladora.detalledenuncia = '';

      setState(() {
        _guardando = true;
      });

      if (foto != null) {
        recicladora.fotourl = await recicladoraProvider.subirimagen(foto);
      }

      _mensajes(context);
      recicladora.fecha = DateTime.now().toString();
      if (recicladora.id == null) {
        recicladoraProvider.crearRevision(recicladora);
      } else {
        recicladoraProvider.editarRevision(recicladora);
      }
      mostrarSnackbar("Registro Guardado ");
      setState(() {
        _guardando = false;
      });
    } else {
      mostrarAlerta(context, 'Debes elegir una ciudad');
    }
  }

  void _mensajes(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Registro exitoso'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'Gracias, se agregaron los cambios del/la reciclador/a en la base de datos'),
                Image(image: AssetImage('assets/registro.png')),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.pushNamed(context, 'inicio'),
              )
            ],
          );
        });
  }

  Widget _mostrarFoto() {
    if (recicladora.fotourl != null) {
      return Container();
      //Falta implementar esto
    } else {
      if (foto != null) {
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  Future _procesarImagen(ImageSource origen) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: origen);

    if (pickedFile != null) {
      print("limpieza");
    }
    setState(() {
      foto = File(pickedFile.path);
      print(foto.path);
    });
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
        content: Text(mensaje), duration: Duration(milliseconds: 3000));
    scaffoldkey.currentState.showSnackBar(snackbar);
  }
}
