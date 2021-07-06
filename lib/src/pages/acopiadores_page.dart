// import 'dart:html';

import 'dart:io';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:redciclapp/src/providers/acopio_provider.dart';
import 'package:redciclapp/src/utils/utils.dart';
import 'package:redciclapp/src/models/acopiador_model.dart';
import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';

class AcopiadorPage extends StatefulWidget {
  AcopiadorPage({Key key}) : super(key: key);

  @override
  _AcopiadorPageState createState() => _AcopiadorPageState();
}

// class AcopiadorPage extends StatefulWidget {
//   @override
//   // _AcopiadorPage createState() => _AcopiadorState();
// }

class _AcopiadorPageState extends State<AcopiadorPage> {
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

  // bool _guardando = false;

  File foto;
  bool _foto1 = false;
  bool _foto2 = false;
  bool _foto3 = false;
  bool _foto4 = false;

  bool _otraZona = false;

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
      _opcionSeleccionada = recData.ciudad;
      _zonaElegida = recData.zona;
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
                      _mensajefotos(),
                      _fotosPredeterminadas(),
                      SizedBox(
                        height: 20.0,
                      ),
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
                      _zona(),
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
                      _mapear(),
                      _mapa(_quieresMapear),
                      _crearBoton(context, recData),
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
        helperText: 'Escribe solo un número, sin añadir +591',
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
        helperText: '3 principales residuos que acopia',
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

  Widget _zona() {
    if (_otraZona) {
      return TextFormField(
        initialValue: 'Otras',
        cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            labelText: "Escribe aquí el nombre de la zona:"),
        onSaved: (value) => acopiador.zona = value,
      );
    } else {
      return SizedBox();
    }
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
            items: getOpcionesDropDownZ(),
            onChanged: (opt) {
              if (opt == "Otras") {
                setState(() {
                  _otraZona = true;
                  _zonaElegida = opt;
                });
              } else {
                setState(() {
                  _otraZona = false;
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

  Widget _detalles() {
    return TextFormField(
      initialValue: acopiador.detalles,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        helperText: 'Cualquier detalle que quieras agregar',
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

  Widget _crearBoton(BuildContext context, Acopiador data) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Color.fromRGBO(34, 181, 115, 1.0),
      textColor: Colors.white,
      onPressed: () {
        if (_guardando == false) {
          _submit(context, data);
        }
      },
      icon: Icon(Icons.save),
      label: Text('Guardar'),
    );
  }

  void _submit(BuildContext context, Acopiador data) async {
    if (_opcionSeleccionada != 'Elegir') {
      formkey.currentState.validate();
      formkey.currentState.save();
      //Con esto vamos a permitir la edicion de entradas:
      if (data != null) {
        acopiador.correo = data.correo;
      } else {
        acopiador.correo = prefs.email;
      }

      //Esta variable controla si se publica o no el punto de acopio
      acopiador.aprobacion = 'pendiente';

      //Para controlar los registros reportados
      acopiador.tienedenuncia = 'No';
      acopiador.detalledenuncia = '';

      setState(() {
        _guardando = true;
      });

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
                    'Gracias, esta publicación esta será revisada y aprobada por los administradores'),
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

  Widget _mensajefotos() {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: Text(
          "Carga una foto de tu punto de acopio utilizando los botones de arriba a la derecha, si no tienes una foto puedes hacer clic en alguna de las siguientes fotos predeterminadas.",
          style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
        ));
  }

  Widget _fotosPredeterminadas() {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _foto1 = true;
                _foto2 = false;
                _foto3 = false;
                _foto4 = false;
                _usarPredeterminadas('assets/carton.jpeg');
              });
            },
            child: Container(
              height: 70.0,
              child: Image.asset('assets/carton.jpeg'),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _foto1 = false;
                _foto2 = true;
                _foto3 = false;
                _foto4 = false;
                _usarPredeterminadas('assets/vidrio.jpg');
              });
            },
            child: Container(
              height: 70.0,
              child: Image.asset('assets/vidrio.jpg'),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _foto1 = false;
                _foto2 = false;
                _foto3 = true;
                _foto4 = false;
                _usarPredeterminadas('assets/plastic.jpg');
              });
            },
            child: Container(
              height: 70.0,
              child: Image.asset('assets/plastic.jpg'),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _foto1 = false;
                _foto2 = false;
                _foto3 = false;
                _foto4 = true;
                _usarPredeterminadas('assets/latas.jpg');
              });
            },
            child: Container(
              height: 70.0,
              child: Image.asset('assets/latas.jpg'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mostrarFoto() {
    if (acopiador.fotourl != null) {
      return Container(
        child: FadeInImage(
            placeholder: AssetImage('assets/barline_loading.gif'),
            image: NetworkImage(acopiador.fotourl)),
      );
      //Falta implementar esto
    } else {
      if (foto != null) {
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      if (_foto1 == true) {
        setState(() {});
        return Image.asset('assets/carton.jpeg');
      } else if (_foto2 == true) {
        setState(() {});
        return Image.asset('assets/vidrio.jpg');
      } else if (_foto3 == true) {
        setState(() {});
        return Image.asset('assets/plastic.jpg');
      } else if (_foto4 == true) {
        setState(() {});
        return Image.asset('assets/latas.jpg');
      } else {
        setState(() {});
        return Image.asset('assets/no-image.png');
      }
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _usarPredeterminadas(String path) async {
    foto = await urlToFile('$path');
    print(foto.path);
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

  Future<File> urlToFile(String imagePath) async {
    var rng = new Random();
    var bytes = await rootBundle.load('$imagePath');
    String tempPath = (await getTemporaryDirectory()).path;
    File file = new File('$tempPath' + (rng.nextInt(1000)).toString() + '.png');

    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

    return file;
  }
}
