import 'package:flutter/material.dart';
//import 'package:redciclapp/src/bloc/provider2.dart';

import 'package:redciclapp/src/models/acopiador_model.dart';
import 'package:redciclapp/src/models/ecoemprendimiento_model.dart';
import 'package:redciclapp/src/models/recicladora_model.dart';
import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:redciclapp/src/providers/acopio_provider.dart';
import 'package:redciclapp/src/providers/ecoemprendimiento_provider.dart';
import 'package:redciclapp/src/providers/recicladora_provider.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';

class Aprobaciones extends StatefulWidget {
  // const Inicio({Key key}) : super(key: key);
  @override
  _AprobacionesState createState() => _AprobacionesState();
}

Color colorRecicladora = Colors.white;
Color colorEcoemprendimiento = Colors.white;
Color colorAcopiador = Colors.white;

class _AprobacionesState extends State<Aprobaciones> {
  final centroAcopioProvider = new CentroAcopioProvider();
  final ecoemprendimientoProvider = new EcoemprendimientoProvider();
  final recicladoraProvider = new RecicladoraProvider();
  List<Acopiador> _centrosAcopio = List<Acopiador>();
  List<Acopiador> _centrosAcopiofiltrado = List<Acopiador>();
  final prefs = new PreferenciasUsuario();

  String contenedor = 'acopiadores';

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

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider2.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
        //leading: Icon(Icons.search),
        title: _searchBar(),
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          _botones(),
          SizedBox(height: 10),
          _elegirciudad(),
          _elegirContenedor(),
          _explicacion(),
        ],
      ),
      // bottomNavigationBar: _bottonNavigationBar(context)
    );
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

    // if (contenedor == "acopiadores") {
    //   return _listadoAcopiadores();
    // } else {
    //   return Container();
    // }
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
                color: colorRecicladora,
                image: DecorationImage(
                  image: AssetImage('assets/residuos.png'),
                ),
              ),
              child: new FlatButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    setState(() {
                      colorRecicladora = Colors.green[900];
                      colorAcopiador = Colors.white;
                      colorEcoemprendimiento = Colors.white;
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
                color: colorEcoemprendimiento,
                image: DecorationImage(
                  image: AssetImage('assets/eco_emprendimiento.png'),
                ),
              ),
              child: new FlatButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    setState(() {
                      colorRecicladora = Colors.white;
                      colorAcopiador = Colors.white;
                      colorEcoemprendimiento = Colors.green[900];
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
                color: colorAcopiador,
                image: DecorationImage(
                  image: AssetImage('assets/ubicacion.png'),
                ),
              ),
              child: new FlatButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    setState(() {
                      colorRecicladora = Colors.white;
                      colorAcopiador = Colors.green[900];
                      colorEcoemprendimiento = Colors.white;
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
            hintText: 'Administradores',
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
                        if (_centrosAcopiofiltrado[i].ciudad == _ciudad &&
                            prefs.email == 'redciclabolivia@gmail.com' &&
                            _centrosAcopiofiltrado[i].aprobacion ==
                                'pendiente') {
                          return _itemCentroAcopio(
                            context,
                            _centrosAcopiofiltrado[i],
                          );
                        } else if (_centrosAcopiofiltrado[i].ciudad ==
                                _ciudad &&
                            prefs.email == 'redciclabol@gmail.com' &&
                            _centrosAcopiofiltrado[i].aprobacion ==
                                'pendiente') {
                          return _itemCentroAcopio(
                              context, _centrosAcopiofiltrado[i]);
                        } else if (_centrosAcopiofiltrado[i].ciudad ==
                                _ciudad &&
                            prefs.email == 'redciclabolivia@gmail.com' &&
                            _centrosAcopiofiltrado[i].tienedenuncia == 'Si') {
                          return _itemCentroAcopio(
                            context,
                            _centrosAcopiofiltrado[i],
                          );
                        } else if (_centrosAcopiofiltrado[i].ciudad ==
                                _ciudad &&
                            prefs.email == 'redciclabol@gmail.com' &&
                            _centrosAcopiofiltrado[i].tienedenuncia == 'Si') {
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
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      // direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        centroAcopioProvider.borrarRegistro(acopio.id);
      },
      child: (ListTile(
        leading: Image(
            image: AssetImage('assets/ubicacion.png'), height: 25, width: 25),
        trailing: IconButton(
            icon: Icon(Icons.map),
            onPressed: () =>
                Navigator.pushNamed(context, 'mapa', arguments: acopio)),
        title: Text(
          '${acopio.nombre}',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
        ),
        subtitle:
            Text('${acopio.ciudad} - ${acopio.zona} - ${acopio.querecibe}'),
        onTap: () =>
            Navigator.pushNamed(context, 'acopiadoresrev', arguments: acopio),
      )),
    );
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
                          if (ecoemprendimientos[i].ciudad == _ciudad &&
                              prefs.email == 'redciclabolivia@gmail.com' &&
                              ecoemprendimientos[i].tienedenuncia == 'Si') {
                            return _itemEcoemprendimiento(
                                context, ecoemprendimientos[i]);
                          } else if ((ecoemprendimientos[i].ciudad == _ciudad &&
                              prefs.email == "redciclabol@gmail.com" &&
                              ecoemprendimientos[i].tienedenuncia == 'Si')) {
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
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        ecoemprendimientoProvider.borrarRegistro(eco.id);
      },
      child: (ListTile(
        leading: Image(
            image: AssetImage('assets/eco_emprendimiento.png'),
            height: 25,
            width: 25),
        trailing: IconButton(icon: Icon(Icons.map), onPressed: () {}),
        title: Text(
          '${eco.nombre}',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
        ),
        subtitle: Text('${eco.ciudad} - ${eco.zona} - ${eco.capacidad}'),
        onTap: () => Navigator.pushNamed(context, 'ecosrev', arguments: eco),
      )),
    );
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
                          if (recicladoras[i].departamento == _ciudad &&
                              prefs.email == "redciclabolivia@gmail.com" &&
                              recicladoras[i].tienedenuncia == 'Si') {
                            return _itemRecicladora(context, recicladoras[i]);
                          } else if (recicladoras[i].departamento == _ciudad &&
                              prefs.email == "redciclabol@gmail.com" &&
                              recicladoras[i].tienedenuncia == 'Si') {
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

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        recicladoraProvider.borrarRegistro(recicladora.id);
      },
      child: (ListTile(
        leading: Image(
            image: AssetImage('assets/residuos.png'), height: 25, width: 25),
        trailing:
            IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () {}),
        title: Text(
          '${recicladora.nombre}',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
        ),
        subtitle: Text('${recicladora.departamento} - ${recicladora.zona}'),
        onTap: () => Navigator.pushNamed(context, 'recicladorasrev',
            arguments: recicladora),
      )),
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

  // Widget _bottonNavigationBar(BuildContext context) {
  //   return new Theme(
  //     data: Theme.of(context).copyWith(
  //       canvasColor: Color.fromRGBO(34, 181, 115, 1.0),
  //       primaryColor: Colors.white,
  //     ),
  //     child: BottomNavigationBar(items: [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home, size: 30.0),
  //         title: Container(),
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.view_agenda, size: 30.0),
  //         title: Container(),
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.exit_to_app, size: 30.0),
  //         title: Container(),
  //       ),
  //     ]),
  //   );
  // }

  _explicacion() {
    return Container(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Text(
              "Solo los administradores pueden ver contenido en esta página, si consideras que debes ver algo acá, contáctanos."),
        ));
  }
}
