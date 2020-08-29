import 'package:redciclapp/src/providers/separador_provider.dart';
import 'package:redciclapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:redciclapp/src/models/separador_model.dart';
import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
//

class SeparadorPage extends StatefulWidget {
  SeparadorPage({Key key}) : super(key: key);

  @override
  _SeparadorPageState createState() => _SeparadorPageState();
}

// class SeparadorPage extends StatefulWidget {
//   @override
//   // _SeparadorPage createState() => _separadorState();
// }

class _SeparadorPageState extends State<SeparadorPage> {
  final prefs = new PreferenciasUsuario();

  List<String> _localidades = [
    'Elegir',
    'Beni',
    'Cochabamba',
    'El Alto',
    'La Paz',
    'Oruro',
    'Pando',
    'Potosí',
    'Santa Cruz',
    'Sucre',
    'Tarija',
  ];
  String _opcionSeleccionada = 'Elegir';

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

  final formkey = GlobalKey<FormState>();
  final separadorProvider = new CentroAcopioProvider();

  Separador separador = new Separador();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
          title: Text('Añadir persona que separa',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/reciclar.png'),
                radius: 25.0,
              ),
            ),
          ]),
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(15.0),
              child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      _nombreCompleto(),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        '¿En qué departamento vives?',
                        textAlign: TextAlign.left,
                      ),
                      _elegirdepartamento(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _elegirzona(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _queSepara(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _zona(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _celular(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _detalles(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _crearBoton(context),
                    ],
                  )))),
    );
  }

  Widget _nombreCompleto() {
    return TextFormField(
      initialValue: separador.nombre,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          labelText: "Nombre del reciclador/a "),
      onSaved: (value) => separador.nombre = value,
    );
  }

  Widget _queSepara() {
    return TextFormField(
      initialValue: separador.quesepara,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          labelText: "¿Que residuos recolecta?"),
      onSaved: (value) => separador.quesepara = value,
    );
  }

  Widget _celular() {
    return TextFormField(
      initialValue: separador.celular,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          labelText: "Nro de celular:"),
      onSaved: (value) => separador.celular = value,
    );
  }

  Widget _zona() {
    return TextFormField(
      initialValue: separador.zona,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          labelText: "¿Qué zona es?"),
      onSaved: (value) => separador.zona = value,
    );
  }

  Widget _detalles() {
    return TextFormField(
      initialValue: separador.detalles,
      cursorColor: Color.fromRGBO(34, 181, 115, 1.0),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          labelText: "Detalles o comentarios"),
      onSaved: (value) => separador.detalles = value,
    );
  }

  Widget _elegirdepartamento() {
    return Row(
      children: <Widget>[
        Icon(Icons.place, color: Colors.cyan),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: _opcionSeleccionada,
            items: getOpcionesDropDown(),
            onChanged: (opt) {
              setState(() {
                _opcionSeleccionada = opt;
                separador.departamento = _opcionSeleccionada;
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
              if (_zonaElegida == "otra") {
                _zona();
              } else {
                setState(() {
                  _zonaElegida = opt;
                  separador.zona = _zonaElegida;
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

  void _submit(BuildContext context) {
    if (_opcionSeleccionada != 'Elegir') {
      formkey.currentState.validate();
      formkey.currentState.save();
      _mensajes(context);
      separador.fecha = DateTime.now().toString();

      separadorProvider.crearRevision(separador);
    } else {
      mostrarAlerta(context, 'Debes elegir un departamento');
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
                    'Gracias, te agregamos como separador/a de residuos en la base de datos'),
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
}
