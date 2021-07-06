import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:redciclapp/src/models/pedido_model.dart';
import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:redciclapp/src/providers/pedido_provider.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';

class SolicitudesPage extends StatelessWidget {
  final pedidoProvider = new PedidoProvider();
  final prefs = new PreferenciasUsuario();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(34, 181, 115, 1.0),
          //leading: Icon(Icons.search),
          title: Text('Solicitudes de contacto'),
        ),
        drawer: MenuWidget(),
        body: ListView(children: <Widget>[_crearlistado(), _crearlistado2()]));
  }

//Se hace el match entre las solicitudes que tienen como usuario creador al correo
//electrónico del usuario que tiene la cuenta activa.

  Widget _crearlistado() {
    //Solicitudes de contacto hechas por el usuario
    return ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 0),
            child: Text(
              'Mis solicitudes de contacto:',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 20),
              height: 300,
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
                  future: pedidoProvider.cargarPedido(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Pedido>> snapshot) {
                    if (snapshot.hasData) {
                      final solicitudes = snapshot.data;
                      return ListView.builder(
                          itemCount: solicitudes.length,
                          itemBuilder: (context, i) {
                            if (solicitudes[i].correo == prefs.email) {
                              return _crearItem(context, solicitudes[i]);
                            } else {
                              return SizedBox();
                            }
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
        ]);
  }

//Para que el listado2 funcione es necesario crear una cuenta a cada recicladora,
//ecoemprendimiento y Centro de acopio, y recien desde esa cuenta mapearlos; para
//que puedan recibir la notificación de que tienen una nueva solicitud de contacto.

  Widget _crearlistado2() {
    //Solicitudes de contacto hechas al usuario
    return ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 0),
            child: Text(
              'Solicitudes de contacto para mi:',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 20),
              height: 300,
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
                  future: pedidoProvider.cargarPedido(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Pedido>> snapshot) {
                    if (snapshot.hasData) {
                      final solicitudes = snapshot.data;
                      return ListView.builder(
                          itemCount: solicitudes.length,
                          itemBuilder: (context, i) {
                            if (solicitudes[i].correo2 == prefs.email) {
                              return _crearItem(context, solicitudes[i]);
                            } else {
                              return SizedBox();
                            }
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
        ]);
  }

  Widget _crearItem(BuildContext context, Pedido pedido) {
    return ListTile(
      title: Text('Solicitud de contacto a: ' + '${pedido.aquien}'),
      subtitle: Text('${pedido.actor}' + '${pedido.fecha}'),
      onTap: () =>
          Navigator.pushNamed(context, 'vistasolicitud', arguments: pedido),
    );
  }
}
