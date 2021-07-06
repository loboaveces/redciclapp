// import 'dart:html';

import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:redciclapp/src/providers/recicladora_provider.dart';
import 'package:redciclapp/src/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:redciclapp/src/models/recicladora_model.dart';
import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';
//

class RecicladoraPage extends StatefulWidget {
  RecicladoraPage({Key key}) : super(key: key);

  @override
  _RecicladoraPageState createState() => _RecicladoraPageState();
}

// class RecicladoraPage extends StatefulWidget {
//   @override
//   // _RecicladoraPage createState() => _RecicladoraState();
// }

class _RecicladoraPageState extends State<RecicladoraPage> {
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

  bool _otraZona = false;

  File foto;
  bool _foto1 = false;
  bool _foto2 = false;
  bool _foto3 = false;
  bool _foto4 = false;

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
      _opcionSeleccionada = recData.departamento;
      _zonaElegida = recData.zona;
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
                      _elegirdepartamento(),
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

                      _crearBoton(context, recData),
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
        helperText: 'Sólo números, sin agregar +591',
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
        helperText: 'Nombre completo',
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
        helperText: '¿De qué hora a qué hora?',
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
        helperText: 'Los 3 residuos principales que recolecta',
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
        helperText: 'Las 2 calles principales que recorre',
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

  // Widget _zona() {
  //   print(_otraZona);
  //   if (_otraZona == true) {
  //     return TextFormField(
  //       initialValue: recicladora.zona,
  //       cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
  //       textCapitalization: TextCapitalization.sentences,
  //       decoration: InputDecoration(
  //         contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
  //         labelText: "¿Qué zona recorre?",
  //         labelStyle: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
  //         icon: Icon(
  //           Icons.location_city,
  //           color: Color.fromRGBO(34, 181, 115, 1.0),
  //         ),
  //         enabledBorder: UnderlineInputBorder(
  //           borderSide: BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
  //         ),
  //         focusedBorder: UnderlineInputBorder(
  //           borderSide: BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
  //         ),
  //         border: UnderlineInputBorder(
  //           borderSide: BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
  //         ),
  //       ),
  //       onSaved: (value) => recicladora.zona = value,
  //     );
  //   } else {
  //     return SizedBox();
  //   }
  // }

  Widget _detalles() {
    return TextFormField(
      initialValue: recicladora.detalles,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        helperMaxLines: 2,
        helperText:
            'Cualquier detalle que consideres relevante sobre esta recicladora',
        labelText: "Detalles adicionales",
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
            value: _opcionSeleccionada,
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
            value: _zonaElegida,
            style: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
            items: getOpcionesDropDownZ(),
            onChanged: (opt) {
              if (opt == 'Otras') {
                setState(() {
                  _otraZona = true;
                  _zonaElegida = opt;
                });
                print(_otraZona);
              } else {
                setState(() {
                  _otraZona = false;
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
    if (_otraZona) {
      return TextFormField(
        initialValue: 'Otras',
        cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            labelText: "Escribe aquí el nombre de la zona:"),
        onSaved: (value) => recicladora.zona = value,
      );
    } else {
      return SizedBox();
    }
  }

  Widget _crearBoton(BuildContext context, Recicladora recdata) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Color.fromRGBO(34, 181, 115, 1.0),
      textColor: Colors.white,
      onPressed: () {
        if (_guardando == false) {
          _submit(context, recdata);
        }
      },
      icon: Icon(Icons.save),
      label: Text('Guardar'),
    );
  }

  void _submit(BuildContext context, Recicladora data) async {
    if (_opcionSeleccionada != 'Elegir') {
      formkey.currentState.validate();
      formkey.currentState.save();
      //Con esto vamos a permitir la edicion de entradas:
      if (data != null) {
        recicladora.correo = data.correo;
      } else {
        recicladora.correo = prefs.email;
      }

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

  Widget _mensajefotos() {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: Text(
          "Para cargar una foto utiliza los botones de arriba a la derecha, si no tienes una foto puedes hacer clic en alguna de las siguientes fotos predeterminadas.",
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
    if (recicladora.fotourl != null) {
      return Container(
          child: FadeInImage(
              placeholder: AssetImage('assets/barline_loading.gif'),
              image: NetworkImage(recicladora.fotourl)));
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
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');

    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

    return file;
  }
}
