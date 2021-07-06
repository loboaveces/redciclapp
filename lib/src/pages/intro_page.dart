import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:redciclapp/src/pages/inicio_page.dart';

class IntroPage extends StatelessWidget {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
          image: Image(
            image: AssetImage('assets/intro.jpg'),
          ),
          title: "Bienvenido/a",
          body:
              "REDcicla es una iniciativa ciudadana que busca fortalecer la cadena de valor en la gestión de residuos sólidos, conectando a todos los actores que forman parte de ella."),
      PageViewModel(
          image: Image(
            image: AssetImage('assets/recicladoras.jpg'),
          ),
          title: "Recicladoras de base",
          body:
              "Impulsamos el reciclaje inclusivo, desde la valoración y visibilización del aporte que realizan las recicladoras de base en la gestión y aprovechamiento de los residuos sólidos."),
      PageViewModel(
          image: Image(
            image: AssetImage('assets/ecoemprendimientos.jpg'),
          ),
          title: "Ecoemprendimientos",
          body:
              "Valoramos y apoyamos a negocios y empresas con un enfoque responsable hacia nuestro entorno y la madre tierra"),
      PageViewModel(
          image: Image(
            image: AssetImage('assets/acopio.jpg'),
          ),
          title: "Centros de Acopio",
          body:
              "Centralizamos información en formato abierto para que cada vez más personas seamos parte del ciclo de reciclaje"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          showSkipButton: true,
          skip: const Text("Saltar"),
          done: Text(
            'Empezar',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onDone: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Inicio()));
          },
          onSkip: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Inicio()));
          },
          pages: getPages(),
        ),
      ),
    );
  }

  final logo = Image(
    image: AssetImage('assets/logoclean.png'),
    height: 100,
  );

  final fondo = Image(
    image: AssetImage('assets/icono-opaco.png'),
    height: 300,
  );
}
