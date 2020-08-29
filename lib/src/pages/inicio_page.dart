import 'package:flutter/material.dart';
//import 'package:redciclapp/src/bloc/provider2.dart';

import 'package:redciclapp/src/models/acopiador_model.dart';
import 'package:redciclapp/src/models/ecoemprendimiento_model.dart';
import 'package:redciclapp/src/models/recicladora_model.dart';
import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:redciclapp/src/providers/acopio_provider.dart';
import 'package:redciclapp/src/providers/ecoemprendimiento_provider.dart';
import 'package:redciclapp/src/providers/recicladora_provider.dart';

class Inicio extends StatefulWidget {
  // const Inicio({Key key}) : super(key: key);
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final centroAcopioProvider = new CentroAcopioProvider();
  final ecoemprendimientoProvider = new EcoemprendimientoProvider();
  final recicladoraProvider = new RecicladoraProvider();
  List<Acopiador> _centrosAcopio = List<Acopiador>();
  List<Acopiador> _centrosAcopiofiltrado = List<Acopiador>();

  String contenedor = 'recicladoras';

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
  String _ciudad = '';

  final prefs = new PreferenciasUsuario();
  // var _busqueda = new TextEditingController();
  // bool _1erabusqueda = true;
  // String _query = "";

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider2.of(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
          leading: Icon(Icons.search),
          title: _searchBar(),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            _botones(),
            SizedBox(height: 10),
            _elegirciudad(),
            _elegirContenedor(),
            _crearBoton(context),
          ],
        ),
        bottomNavigationBar: _bottonNavigationBar(context));
  }

  Widget _elegirContenedor() {
    if (contenedor == "recicladoras") {
      return _listadoRecicladoras();
    } else if (contenedor == "acopiadores") {
      return _listadoAcopiadores();
    } else if (contenedor == "ecoemprendimientos") {
      return _listadoEcoemprendimientos();
    } else {
      return Container();
    }
  }

  Widget _botones() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 40,
        ),
        Column(
          children: <Widget>[
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/residuos.png'),
                ),
              ),
              child: new FlatButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    setState(() {
                      contenedor = 'recicladoras';
                    });
                  },
                  child: null),
            ),
            SizedBox(height: 5.0),
            Text(
              'Recicladoras\nde base',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Expanded(
          child: SizedBox(
            width: 30,
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/eco_emprendimiento.png'),
                ),
              ),
              child: new FlatButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    setState(() {
                      contenedor = 'ecoemprendimientos';
                    });
                  },
                  child: null),
            ),
            SizedBox(height: 5.0),
            Text(
              'Eco\nemprendimientos',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Expanded(
          child: SizedBox(
            width: 30,
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ubicacion.png'),
                ),
              ),
              child: new FlatButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    setState(() {
                      contenedor = 'acopiadores';
                    });
                  },
                  child: null),
            ),
            SizedBox(height: 5.0),
            Text(
              'Puntos\nde acopio',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(
          width: 40,
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: '¿Qué estas buscando?',
            hintStyle: TextStyle(color: Colors.white),
          ),
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              _centrosAcopiofiltrado = _centrosAcopio
                  .where(
                      (value) => value.querecibe.toLowerCase().contains(text))
                  .toList();
            });
          },
        ));
  }

  Widget _listadoAcopiadores() {
    return ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 20),
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // posición de la sombra de la caja
                ),
              ],
            ),
            child: FutureBuilder(
                future: centroAcopioProvider.cargarAcopiadores(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Acopiador>> snapshot) {
                  if (snapshot.hasData) {
                    _centrosAcopio = _centrosAcopiofiltrado = snapshot.data;
                    return ListView.builder(
                      itemBuilder: (context, i) {
                        if (_centrosAcopiofiltrado[i].ciudad == _ciudad) {
                          return _itemCentroAcopio(
                              context, _centrosAcopiofiltrado[i]);
                        } else {
                          return SizedBox();
                        }
                      },
                      itemCount: _centrosAcopiofiltrado.length,
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          )
        ]);
  }

  Widget _itemCentroAcopio(BuildContext context, Acopiador acopio) {
    return (ListTile(
      leading: Image(
          image: AssetImage('assets/ubicacion.png'), height: 25, width: 25),
      trailing:
          IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () {}),
      title: Text(
        '${acopio.nombre}',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
      ),
      subtitle:
          Text('${acopio.ciudad} - ${acopio.barrio} - ${acopio.querecibe}'),
      onTap: () =>
          Navigator.pushNamed(context, 'acopiadores', arguments: acopio),
    ));
  }

  Widget _listadoEcoemprendimientos() {
    return ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 20),
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // posición de la sombra de la caja
                ),
              ],
            ),
            child: FutureBuilder(
                future: ecoemprendimientoProvider.cargarEmprendimiento(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Ecoemprendimiento>> snapshot) {
                  if (snapshot.hasData) {
                    final ecoemprendimientos = snapshot.data;
                    return ListView.builder(
                        itemCount: ecoemprendimientos.length,
                        itemBuilder: (context, i) {
                          if (ecoemprendimientos[i].ciudad == _ciudad) {
                            return _itemEcoemprendimiento(
                                context, ecoemprendimientos[i]);
                          } else {
                            return SizedBox();
                          }
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          )
        ]);
  }

  Widget _itemEcoemprendimiento(BuildContext context, Ecoemprendimiento eco) {
    print(eco.zona);
    print(eco.celular);
    print(eco.ciudad); //ok
    print(eco.correo); //ok
    print(eco.detalles); //ok
    print(eco.direccion); //ok
    print(eco.fecha); //ok
    print(eco.fotourl); //ok
    print(eco.horarios);
    print(eco.id); //ok
    print(eco.latitud);
    print(eco.longitud);
    print(eco.nombre); //ok
    print(eco.quenecesita);
    print(eco.capacidad); //ok
    print(eco.descripcion);
    return (ListTile(
      leading: Image(
          image: AssetImage('assets/eco_emprendimiento.png'),
          height: 25,
          width: 25),
      trailing:
          IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () {}),
      title: Text(
        '${eco.nombre}',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
      ),
      subtitle: Text('${eco.ciudad} - ${eco.zona} - ${eco.capacidad}'),
      onTap: () => Navigator.pushNamed(context, 'ecos', arguments: eco),
    ));
  }

  Widget _listadoRecicladoras() {
    return ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 20),
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // posición de la sombra de la caja
                ),
              ],
            ),
            child: FutureBuilder(
                future: recicladoraProvider.cargarRecicladora(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Recicladora>> snapshot) {
                  if (snapshot.hasData) {
                    final recicladoras = snapshot.data;
                    return ListView.builder(
                        itemCount: recicladoras.length,
                        itemBuilder: (context, i) {
                          if (recicladoras[i].departamento == _ciudad) {
                            return _itemRecicladora(context, recicladoras[i]);
                          } else {
                            return SizedBox();
                          }
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          )
        ]);
  }

  Widget _itemRecicladora(BuildContext context, Recicladora recicladora) {
    print(recicladora.zona);
    print(recicladora.celular);
    print(recicladora.departamento); //ok
    print(recicladora.correo); //ok
    print(recicladora.detalles); //ok
    print(recicladora.ruta); //ok
    print(recicladora.fecha); //ok
    print(recicladora.fotourl); //ok
    print(recicladora.horarios);
    print(recicladora.id); //ok
    print(recicladora.nombre); //ok
    print(recicladora.recolecta);
    print(recicladora.dias);

    return (ListTile(
      leading: Image(
          image: AssetImage('assets/residuos.png'), height: 25, width: 25),
      trailing:
          IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () {}),
      title: Text(
        '${recicladora.nombre}',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
      ),
      subtitle: Text('${recicladora.departamento} - ${recicladora.zona}'),
      onTap: () =>
          Navigator.pushNamed(context, 'recicladoras', arguments: recicladora),
    ));
  }

  Widget _crearBoton(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
          child: Text(
            'Nuestra base de datos es abierta y alimentada por toda la comunidad de Redcicla, para registrar nuevos datos en nuestra base de datos haz clic aquí:',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15),
          ),
        ),
        SizedBox(height: 5),
        RaisedButton.icon(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: Colors.orange,
          textColor: Colors.white,
          onPressed: () => Navigator.pushNamed(context, 'home'),
          icon: Icon(Icons.map),
          label: Text('Ingresar nuevos datos'),
        ),
      ],
    );
  }

  Widget _elegirciudad() {
    return Row(
      children: <Widget>[
        SizedBox(width: 40.0),
        Icon(Icons.place, color: Color.fromRGBO(34, 181, 115, 1.0)),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: _opcionSeleccionada,
            style: TextStyle(
                color: Color.fromRGBO(34, 181, 115, 1.0), fontSize: 16),
            items: getOpcionesDropDown(),
            onChanged: (opt) {
              setState(() {
                _opcionSeleccionada = opt;
                _ciudad = _opcionSeleccionada;
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

  Widget _bottonNavigationBar(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(34, 181, 115, 1.0),
        primaryColor: Colors.white,
      ),
      child: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 30.0),
          title: Container(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_agenda, size: 30.0),
          title: Container(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.exit_to_app, size: 30.0),
          title: Container(),
        ),
      ]),
    );
  }
}
