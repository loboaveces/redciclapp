import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
//import 'package:redciclapp/src/models/acopiador_model.dart';
import 'package:redciclapp/src/providers/acopio_provider.dart';
import 'package:redciclapp/src/providers/ecoemprendimiento_provider.dart';
import 'package:redciclapp/src/providers/recicladora_provider.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final mapCtrl = new MapController();

  final centroAcopioProvider = new CentroAcopioProvider();
  final ecoemprendimientoProvider = new EcoemprendimientoProvider();
  final recicladoraProvider = new RecicladoraProvider();

  //List<Acopiador> _centrosAcopio = List<Acopiador>();
  // List<Acopiador> _centrosAcopiofiltrado = List<Acopiador>();

  // List _lat_acopiadores = [1];
  // List _long_acopiadores = [1];

  double _latitud = -16.51;
  double _longitud = -68.12;
  Position _currentPosition;

  String contenedor = 'recicladoras';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver ubicación'),
        backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                mapCtrl.move(LatLng(_latitud, _longitud), 16);
              })
        ],
      ),
      drawer: MenuWidget(),
      body: Stack(
        children: [
          _crearMapa(),
          // _crearMapaAcopiadores(),
        ],
      ),
    );
  }

  Widget _crearMapa() {
    _getCurrentLocation();
    return FlutterMap(
      mapController: mapCtrl,
      options: MapOptions(
        center: LatLng(-16.51, -68.12),
        zoom: 16,
      ),
      layers: [
        _mapa(),
        _crearMarcadores(_latitud, _longitud),
      ],
    );
  }

  // Widget _crearMapaAcopiadores() {
  //   return FlutterMap(
  //     mapController: mapCtrl,
  //     options: MapOptions(
  //       center: LatLng(-16.51, -68.12),
  //       zoom: 16,
  //     ),
  //     layers: [
  //       _mapa(),
  //       _crearMarcadorcentroacopio(),
  //     ],
  //   );
  // }

  _mapa() {
    return TileLayerOptions(
      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
      subdomains: ['a', 'b', 'c'],
    );
  }

  // _listadoAcopiadores() {
  //   return FutureBuilder(
  //       future: centroAcopioProvider.cargarAcopiadores(),
  //       builder:
  //           (BuildContext context, AsyncSnapshot<List<Acopiador>> snapshot) {
  //         if (snapshot.hasData) {
  //           _centrosAcopiofiltrado = snapshot.data;

  //           int i = 1;
  //           while (i < _centrosAcopiofiltrado.length) {
  //             var lat = double.parse(_centrosAcopiofiltrado[i].latitud);
  //             assert(lat is double);
  //             var long = double.parse(_centrosAcopiofiltrado[i].longitud);
  //             assert(long is double);
  //             _lat_acopiadores.add(lat);
  //             _long_acopiadores.add(long);
  //           }
  //           return SizedBox();
  //         } else {
  //           return Center(child: CircularProgressIndicator());
  //         }
  //       });
  // }

  _crearMarcadores(double latitud, double longitud) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 50.0,
          height: 50.0,
          point: LatLng(latitud, longitud),
          builder: (context) => Container(
                child: Icon(
                  Icons.person_pin_circle,
                  size: 70.0,
                  color: Theme.of(context).primaryColor,
                ),
              ))
    ]);
  }

  // _crearMarcado_ecoemprendimiento(double latitud, double longitud) {
  //   return MarkerLayerOptions(markers: <Marker>[
  //     Marker(
  //         width: 50.0,
  //         height: 50.0,
  //         point: LatLng(latitud, longitud),
  //         builder: (context) => Container(
  //               child: Icon(
  //                 Icons.location_on,
  //                 size: 70.0,
  //                 color: Colors.green,
  //               ),
  //             ))
  //   ]);
  // }

  // ignore: non_constant_identifier_names

  // _crearMarcadorcentroacopio() {
  //   _listadoAcopiadores();
  //   List lat = [];
  //   List long = [];
  //   lat..addAll(_lat_acopiadores);
  //   long..addAll(_long_acopiadores);
  //   lat.forEach((i) {
  //     return MarkerLayerOptions(markers: <Marker>[
  //       Marker(
  //           width: 50.0,
  //           height: 50.0,
  //           point: LatLng(lat[i], long[i]),
  //           builder: (context) => Container(
  //                 child: Icon(
  //                   Icons.location_on,
  //                   size: 70.0,
  //                   color: Colors.red,
  //                 ),
  //               ))
  //     ]);
  //   });
  // }

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
    print(_latitud);
    print(_longitud);
  }

  // Widget _botones() {
  //   return Row(
  //     children: <Widget>[
  //       SizedBox(
  //         width: 40,
  //       ),
  //       Column(
  //         children: <Widget>[
  //           Container(
  //             height: 45,
  //             width: 45,
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                 image: AssetImage('assets/residuos.png'),
  //               ),
  //             ),
  //             child: new FlatButton(
  //                 padding: EdgeInsets.all(0.0),
  //                 onPressed: () {
  //                   setState(() {
  //                     contenedor = 'recicladoras';
  //                   });
  //                 },
  //                 child: null),
  //           ),
  //           SizedBox(height: 5.0),
  //           Text(
  //             'Recicladoras\nde base',
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       ),
  //       Expanded(
  //         child: SizedBox(
  //           width: 30,
  //         ),
  //       ),
  //       Column(
  //         children: <Widget>[
  //           Container(
  //             height: 45,
  //             width: 45,
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                 image: AssetImage('assets/eco_emprendimiento.png'),
  //               ),
  //             ),
  //             child: new FlatButton(
  //                 padding: EdgeInsets.all(0.0),
  //                 onPressed: () {
  //                   setState(() {
  //                     contenedor = 'ecoemprendimientos';
  //                   });
  //                 },
  //                 child: null),
  //           ),
  //           SizedBox(height: 5.0),
  //           Text(
  //             'Eco\nemprendimientos',
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       ),
  //       Expanded(
  //         child: SizedBox(
  //           width: 30,
  //         ),
  //       ),
  //       Column(
  //         children: <Widget>[
  //           Container(
  //             height: 45,
  //             width: 45,
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                 image: AssetImage('assets/ubicacion.png'),
  //               ),
  //             ),
  //             child: new FlatButton(
  //                 padding: EdgeInsets.all(0.0),
  //                 onPressed: () {
  //                   setState(() {
  //                     contenedor = 'acopiadores';
  //                   });
  //                 },
  //                 child: null),
  //           ),
  //           SizedBox(height: 5.0),
  //           Text(
  //             'Puntos\nde acopio',
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       ),
  //       SizedBox(
  //         width: 40,
  //       ),
  //     ],
  //   );
  // }
}
