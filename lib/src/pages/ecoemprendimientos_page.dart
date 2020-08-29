// import 'dart:html';

import 'dart:async';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart';

import 'package:redciclapp/src/providers/ecoemprendimiento_provider.dart';
import 'package:redciclapp/src/models/ecoemprendimiento_model.dart';
import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:redciclapp/src/utils/utils.dart';

class EcoemprendimientoPage extends StatefulWidget {
  EcoemprendimientoPage({Key key}) : super(key: key);

  @override
  _EcoemprendimientoPageState createState() => _EcoemprendimientoPageState();
}

// class EcoemprendimientoPage extends StatefulWidget {
//   @override
//   // _EcoemprendimientoPage createState() => _EcoemprendimientoState();
// }

class _EcoemprendimientoPageState extends State<EcoemprendimientoPage> {
  final prefs = new PreferenciasUsuario();

  MapController controller = new MapController();
  double _latitud = 0.0;
  double _longitud = 0.0;
  Position _currentPosition;

  List<String> _localidades = [
    'Elegir Ciudad',
    // 'Beni',
    // 'Cochabamba',
    // 'El Alto',
    'La Paz',
    // 'Oruro',
    // 'Pando',
    // 'Potosí',
    // 'Santa Cruz',
    // 'Sucre',
    // 'Tarija',
  ];

  List<String> _zonasLpz = [
    //zonas de La Paz
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

  String _opcionSeleccionada = 'Elegir Ciudad';

  bool _quieresMapear = false;

  List<String> _niveles = [
    'Elegir nivel',
    'Capacidad máxima alcanzada',
    'Todavía podemos recibir',
    'Estamos recibiendo',
  ];
  String _opcionSeleccionada2 = 'Elegir nivel';

  // bool _guardando = false;

  File foto;

  final formkey = GlobalKey<FormState>();
  final ecoemprendimientoProvider = new EcoemprendimientoProvider();

  Ecoemprendimiento ecoemprendimiento = new Ecoemprendimiento();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
          title: Text('Añadir Ecoemprendimiento',
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
                      _elegirciudad(),
                      SizedBox(
                        height: 30.0,
                      ),
//horarios
// dias de la semana

                      _celular(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _descripcion(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _quenecesita(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _elegirzona(),
                      SizedBox(
                        height: 30.0,
                      ),

                      _direccion(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _horarios(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _elegircapacidad(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _detalles(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _mapear(),
                      _mapa(_quieresMapear),
                      SizedBox(
                        height: 30.0,
                      ),
                      _crearBoton(context),
                    ],
                  )))),
    );
  }

  Widget _mapear() {
    return SwitchListTile(
      activeColor: Color.fromRGBO(34, 181, 115, 1.0),
      title: Text(
        '¿Te encuentras en el lugar? --> Mapea la ubicación',
        style: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
      ),
      value: _quieresMapear,
      onChanged: (valor) {
        setState(() {
          _quieresMapear = valor;
        });
      },
      //secondary: Image.asset('assets/aliento.png'),
    );
  }

  Widget _mapa(bool mapear) {
    if (mapear) {
      return Container(
        height: 250.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: FlutterMap(
          mapController: controller,
          options: new MapOptions(center: buildMap(), minZoom: 13.0),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            new MarkerLayerOptions(markers: [
              new Marker(
                  width: 45.0,
                  height: 45.0,
                  point: new LatLng(_latitud, _longitud),
                  builder: (context) => new Container(
                        child: IconButton(
                          icon: Icon(Icons.location_on),
                          color: Color.fromRGBO(34, 181, 115, 1.0),
                          iconSize: 45.0,
                          onPressed: () {
                            print("marcador agregado");
                          },
                        ),
                      )),
            ])
          ],
        ),
      );
    } else {
      return Container(
          height: 30.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox());
    }
  }

  _getCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
    _latitud = _currentPosition.latitude;
    _longitud = _currentPosition.longitude;
    ecoemprendimiento.latitud = _latitud.toString();
    ecoemprendimiento.longitud = _longitud.toString();
    print(_latitud);
    print(_longitud);
  }

  buildMap() {
    _getCurrentLocation();
    print(_latitud);
    print(_longitud);
    controller.onReady.then((result) {
      controller.move(LatLng(_latitud, _longitud), 15.0);
    });
  }

  Widget _celular() {
    return TextFormField(
      initialValue: ecoemprendimiento.celular,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "Nro de teléfono o celular:",
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
      onSaved: (value) => ecoemprendimiento.celular = value,
    );
  }

  Widget _nombreCompleto() {
    return TextFormField(
      initialValue: ecoemprendimiento.nombre,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "Nombre del negocio o empresa",
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
      onSaved: (value) => ecoemprendimiento.nombre = value,
    );
  }

  Widget _horarios() {
    return TextFormField(
      initialValue: ecoemprendimiento.horarios,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "Horarios de atención ",
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
      onSaved: (value) => ecoemprendimiento.horarios = value,
    );
  }

  Widget _quenecesita() {
    return TextFormField(
      initialValue: ecoemprendimiento.quenecesita,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "¿Qué materiales necesitan?",
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
      onSaved: (value) => ecoemprendimiento.quenecesita = value,
    );
  }

  Widget _direccion() {
    return TextFormField(
      initialValue: ecoemprendimiento.direccion,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "Escribe la dirección",
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
      onSaved: (value) => ecoemprendimiento.direccion = value,
    );
  }

  Widget _zona() {
    return TextFormField(
      initialValue: ecoemprendimiento.zona,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "¿En qué zona se encuentra?",
        labelStyle: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
        icon: Icon(
          Icons.location_city,
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
      onSaved: (value) => ecoemprendimiento.zona = value,
    );
  }

  Widget _descripcion() {
    return TextFormField(
      initialValue: ecoemprendimiento.descripcion,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "Describe a que se dedican",
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
      onSaved: (value) => ecoemprendimiento.descripcion = value,
    );
  }

  Widget _detalles() {
    return TextFormField(
      initialValue: ecoemprendimiento.detalles,
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
      onSaved: (value) => ecoemprendimiento.detalles = value,
    );
  }

  Widget _elegirciudad() {
    return Row(
      children: <Widget>[
        Icon(Icons.place, color: Color.fromRGBO(34, 181, 115, 1.0)),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: _opcionSeleccionada,
            style: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
            items: getOpcionesDropDown(),
            onChanged: (opt) {
              setState(() {
                _opcionSeleccionada = opt;
                ecoemprendimiento.ciudad = _opcionSeleccionada;
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

// Zonas

  Widget _elegirzona() {
    return Row(
      children: <Widget>[
        Icon(Icons.place, color: Color.fromRGBO(34, 181, 115, 1.0)),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: _zonaElegida,
            style: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
            items: getOpcionesDropDown(),
            onChanged: (opt) {
              if (_zonaElegida == "otra") {
                _zona();
              } else {
                setState(() {
                  _zonaElegida = opt;
                  ecoemprendimiento.zona = _zonaElegida;
                });
              }
            },
          ),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown2() {
    List<DropdownMenuItem<String>> lista = new List();
    _zonasLpz.forEach((zona) {
      lista.add(DropdownMenuItem(
        child: Text(zona),
        value: zona,
      ));
    });

    return lista;
  }

//Zonas

// Capacidad

  Widget _elegircapacidad() {
    return Row(
      children: <Widget>[
        Icon(Icons.place, color: Color.fromRGBO(34, 181, 115, 1.0)),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: _opcionSeleccionada2,
            style: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
            items: getOpcionesDropDown3(),
            onChanged: (opt) {
              setState(() {
                _opcionSeleccionada2 = opt;
                ecoemprendimiento.capacidad = _opcionSeleccionada2;
              });
            },
          ),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown3() {
    List<DropdownMenuItem<String>> lista = new List();
    _niveles.forEach((nivel) {
      lista.add(DropdownMenuItem(
        child: Text(nivel),
        value: nivel,
      ));
    });

    return lista;
  }

//Fin Capacidad

  Widget _crearBoton(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Color.fromRGBO(34, 181, 115, 1.0),
      textColor: Colors.white,
      onPressed: () => _submit(context),
      icon: Icon(Icons.save),
      label: Text('Guardar'),
    );
  }

  // Widget _botonUbicacion(BuildContext context) {
  //   return RaisedButton.icon(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  //     color: Colors.red,
  //     textColor: Colors.white,
  //     onPressed: () {
  //       _checkLocationOperational();
  //       _requestPermission();
  //       _mapa();
  //     },
  //     icon: Icon(Icons.map),
  //     label: Text('Mapear la ubicación (GPS)'),
  //   );
  // }

  void _submit(BuildContext context) async {
    if (_opcionSeleccionada != 'Elegir') {
      formkey.currentState.validate();
      formkey.currentState.save();
      //Con esto vamos a permitir la edicion de entradas:
      ecoemprendimiento.correo = prefs.email;
      // setState(() {
      //   _guardando = true;
      // });

      if (foto != null) {
        ecoemprendimiento.fotourl =
            await ecoemprendimientoProvider.subirimagen(foto);
      }

      _mensajes(context);
      ecoemprendimiento.fecha = DateTime.now().toString();

      ecoemprendimientoProvider.crearRevision(ecoemprendimiento);
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
                    'Gracias, se agregó un nuevo punto de acopio a la base de datos'),
                Image(image: AssetImage('assets/registro.png')),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.pushNamed(context, 'home'),
              )
            ],
          );
        });
  }

  Widget _mostrarFoto() {
    if (ecoemprendimiento.fotourl != null) {
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
}
