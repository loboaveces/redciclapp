import 'dart:math';
import 'package:redciclapp/src/models/pedido_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/rendering.dart';

class RIKeys {
  static final riKey1 = const Key('__RIKEY1__');
  static final riKey2 = const Key('__RIKEY2__');
  static final riKey3 = const Key('__RIKEY3__');
  static final riKey4 = const Key('__RIKEY4__');
  static final riKey5 = const Key('__RIKEY5__');
  static final riKey6 = const Key('__RIKEY6__');
  static final riKey7 = const Key('__RIKEY7__');
  static final riKey8 = const Key('__RIKEY8__');
}

class VistaSolicitud extends StatefulWidget {
  @override
  _VistaSolicitudState createState() => _VistaSolicitudState();
}

ScreenshotController screenshotController = ScreenshotController();

class _VistaSolicitudState extends State<VistaSolicitud> {
  Pedido pedido = new Pedido();
  Future<void> _launched;
  @override
  Widget build(BuildContext context) {
    final Pedido recData = ModalRoute.of(context).settings.arguments;

    pedido = recData;
    pedido.celular = recData.celular;

    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, 'solicitudes'),
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          child: Icon(Icons.arrow_back_ios_outlined),
        ),
        body: Stack(
          children: <Widget>[
            _fondoApp(),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _titulos(),
                  SizedBox(
                    height: 80.0,
                    width: 1,
                  ),
                  _datos(pedido),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.5),
              end: FractionalOffset(0.0, 1.0),
              colors: [Color.fromRGBO(34, 100, 115, 1.0), Colors.green])),
    );
    final cajaBlanca = Transform.rotate(
        angle: -pi / 6.0,
        child: Container(
            height: 300.0,
            width: 400.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(85),
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white],
              ),
            )));
    final cajaLogo = Transform.rotate(
        angle: -pi / 6.0,
        child: Stack(
          children: <Widget>[
            Container(
                height: 300.0,
                width: 400.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(85),
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.white],
                  ),
                )),
            Positioned(
              top: 25.0,
              right: 10,
              child: Transform.rotate(
                angle: pi / 6,
                child: Image(
                  image: AssetImage('assets/logoclean.png'),
                  height: 90,
                ),
              ),
            )
          ],
        ));
    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(top: -180.0, child: cajaBlanca),
        Positioned(bottom: -200.0, right: 130, child: cajaLogo),
      ],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
          padding: EdgeInsets.only(left: 45),
          child: Column(
            children: <Widget>[
              Text(
                'Solicitud de contacto',
                style: TextStyle(
                    color: Color.fromRGBO(34, 181, 115, 1.0),
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Revisa los detalles:',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }

  Widget _datos(Pedido pedido) {
    String toLaunch =
        'https://wa.me/591${pedido.celular}?text=Hola, recibí una solicitud de contacto a través de REDCICLA';
    return Table(
      children: [
        TableRow(key: RIKeys.riKey1, children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  pedido.nombre,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ]),
        TableRow(key: RIKeys.riKey2, children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¿Qué tiene para reciclar? ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  pedido.quecosas,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ]),
        TableRow(key: RIKeys.riKey3, children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fecha propuesta: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  pedido.fecha,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ]),
        TableRow(key: RIKeys.riKey4, children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Horario propuesto: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  pedido.horarios,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ]),
        TableRow(key: RIKeys.riKey5, children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Téléfono (Whatsapp):',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  pedido.celular,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(),
          // _crearBoton(context),
        ]),
        TableRow(key: RIKeys.riKey6, children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Otros detalles: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  pedido.detalles,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () => setState(() {
              _launched = _launchInWebViewOrVC(toLaunch);
              print(_launched.toString());
            }),
            child: const Text('Abrir Whatsapp'),
          ),
          // _compartir(context)
        ]),
        TableRow(key: RIKeys.riKey7, children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detalles: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  pedido.detalles,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ]),
      ],
    );
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
