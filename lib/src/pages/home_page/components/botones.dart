import 'package:flutter/material.dart';

Color colorRecicladora = Colors.white;
Color colorEcoemprendimiento = Colors.white;
Color colorAcopiador = Colors.white;

String contenedor = 'recicladoras';

class Botones extends StatefulWidget {
  const Botones({
    Key key,
  }) : super(key: key);

  @override
  State<Botones> createState() => _BotonesState();
}

class _BotonesState extends State<Botones> {
  @override
  Widget build(BuildContext context) {
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
              child: new TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.all(0.0)),
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
              child: new TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.all(0.0)),
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
              child: new TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.all(0.0)),
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
}
