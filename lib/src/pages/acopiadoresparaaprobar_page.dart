// import 'dart:html';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart';

import 'package:redciclapp/src/providers/acopio_provider.dart';
import 'package:redciclapp/src/utils/utils.dart';
import 'package:redciclapp/src/models/acopiador_model.dart';
import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';

class Acopiador2Page extends StatefulWidget {
  Acopiador2Page({Key key}) : super(key: key);

  @override
  _Acopiador2PageState createState() => _Acopiador2PageState();
}

// class AcopiadorPage extends StatefulWidget {
//   @override
//   // _AcopiadorPage createState() => _AcopiadorState();
// }

class _Acopiador2PageState extends State<Acopiador2Page> {
  final prefs = new PreferenciasUsuario();

  MapController controller = new MapController();
  double _latitud = 0.0;
  double _longitud = 0.0;
  Position _currentPosition;

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

  List<String> _estados = [
    'Pendiente',
    'Aprobado',
  ];
  String _aprobacion = 'Pendiente';

  List<String> _denuncias = [
    'Si',
    'No',
  ];
  String _denuncia = '';
  // bool _guardando = false;

  File foto;

  final formkey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final acopiadorProvider = new CentroAcopioProvider();
  bool _guardando = false;

  bool _quieresMapear = false;
  Acopiador acopiador = new Acopiador();

  @override
  Widget build(BuildContext context) {
    final Acopiador recData = ModalRoute.of(context).settings.arguments;
    if (recData != null) {
      acopiador = recData;
    }

    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
          title: Text('Añadir Punto de Acopio',
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
                      _elegirciudad(),
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
                      _queRecibe(),
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
                      _detalles(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _aprobar(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _tienedenuncia(acopiador),
                      SizedBox(
                        height: 30.0,
                      ),
                      _mapear(),
                      _mapa(_quieresMapear),
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
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Position position =
    //     await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
    _latitud = _currentPosition.latitude;
    _longitud = _currentPosition.longitude;
    acopiador.latitud = _latitud.toString();
    acopiador.longitud = _longitud.toString();
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
      initialValue: acopiador.celular,
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
      onSaved: (value) => acopiador.celular = value,
    );
  }

  Widget _nombreCompleto() {
    return TextFormField(
      initialValue: acopiador.nombre,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "Nombre del punto de acopio ",
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
      onSaved: (value) => acopiador.nombre = value,
    );
  }

  Widget _horarios() {
    return TextFormField(
      initialValue: acopiador.horarios,
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
      onSaved: (value) => acopiador.horarios = value,
    );
  }

  Widget _queRecibe() {
    return TextFormField(
      initialValue: acopiador.querecibe,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "¿Qué residuos recibe?",
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
      onSaved: (value) => acopiador.querecibe = value,
    );
  }

  Widget _direccion() {
    return TextFormField(
      initialValue: acopiador.direccion,
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
      onSaved: (value) => acopiador.direccion = value,
    );
  }

  Widget _aprobar() {
    return Row(
      children: <Widget>[
        Icon(Icons.check_box, color: Colors.black),
        SizedBox(width: 30.0),
        Text('Aprobación del punto de acopio:  '),
        Expanded(
          child: DropdownButton(
            value: _aprobacion,
            style: TextStyle(
              color: Color.fromRGBO(34, 181, 115, 1.0),
            ),
            items: getOpcionesDropDown3(),
            onChanged: (opt) {
              setState(() {
                _aprobacion = opt;
                acopiador.aprobacion = _aprobacion;
              });
            },
          ),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown3() {
    List<DropdownMenuItem<String>> lista = new List();
    _estados.forEach((est) {
      lista.add(DropdownMenuItem(
        child: Text(est),
        value: est,
      ));
    });
    return lista;
  }

  Widget _tienedenuncia(Acopiador acopiador) {
    return Row(
      children: <Widget>[
        Icon(Icons.check_box, color: Colors.black),
        SizedBox(width: 30.0),
        Text('¿El registro fue reportado?  '),
        Expanded(
          child: DropdownButton(
            value: acopiador.tienedenuncia,
            style: TextStyle(
              color: Color.fromRGBO(34, 181, 115, 1.0),
            ),
            items: getOpcionesDropDown4(),
            onChanged: (opt) {
              setState(() {
                _denuncia = opt;
                acopiador.tienedenuncia = _denuncia;
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

  Widget _zona() {
    return TextFormField(
      initialValue: acopiador.zona,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        labelText: "¿En qué zona/barrio se encuentra?",
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
      onSaved: (value) => acopiador.zona = value,
    );
  }

  Widget _elegirzona() {
    return Row(
      children: <Widget>[
        Icon(Icons.location_city, color: Color.fromRGBO(34, 181, 115, 1.0)),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: _zonaElegida,
            style: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
            items: getOpcionesDropDown2(),
            onChanged: (opt) {
              if (_zonaElegida == "otra") {
                _zona();
              } else {
                setState(() {
                  _zonaElegida = opt;
                  acopiador.zona = _zonaElegida;
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

  Widget _detalles() {
    return TextFormField(
      initialValue: acopiador.detalles,
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
      onSaved: (value) => acopiador.detalles = value,
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
                acopiador.ciudad = _opcionSeleccionada;
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

      // setState(() {
      _guardando = true;
      // });

      if (foto != null) {
        acopiador.fotourl = await acopiadorProvider.subirimagen(foto);
      }

      _mensajes(context);
      acopiador.fecha = DateTime.now().toString();
      if (acopiador.id == null) {
        acopiadorProvider.crearRevision(acopiador);
      } else {
        acopiadorProvider.editarRevision(acopiador);
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
                    'Gracias, esta publicación esta sujeta a revisión a si otorga un precio justo'),
                Image(image: AssetImage('assets/registro.png')),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.pushNamed(context, 'aprobaciones'),
              )
            ],
          );
        });
  }

  Widget _mostrarFoto() {
    if (acopiador.fotourl != null) {
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
