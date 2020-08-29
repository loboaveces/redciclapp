import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redciclapp/src/bloc/provider2.dart';
import 'package:redciclapp/src/pages/acopiadores_page.dart';

import 'package:redciclapp/src/pages/home_page.dart';
import 'package:redciclapp/src/pages/inicio_page.dart';
import 'package:redciclapp/src/pages/login_page.dart';
import 'package:redciclapp/src/pages/signin_page.dart';
import 'package:redciclapp/src/pages/splash_page.dart';
import 'package:redciclapp/src/pages/enrutador_page.dart';
import 'package:redciclapp/src/pages/recicladoras_page.dart';
import 'package:redciclapp/src/pages/ecoemprendimientos_page.dart';
import 'package:redciclapp/src/pages/separadores_page.dart';

import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:redciclapp/src/states/current_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider2(
        child: ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Redciclapp',
        initialRoute: 'splash',
        routes: {
          'home': (BuildContext context) => HomePage(),
          'login': (BuildContext context) => LoginPage(),
          'signin': (BuildContext context) => SigninPage(),
          'splash': (BuildContext context) => ScrollPage(),
          'enrutar': (BuildContext context) => RootPage(),
          'recicladoras': (BuildContext context) => RecicladoraPage(),
          'ecos': (BuildContext context) => EcoemprendimientoPage(),
          'separadores': (BuildContext context) => SeparadorPage(),
          'acopiadores': (BuildContext context) => AcopiadorPage(),
          'inicio': (BuildContext context) => Inicio(),
        },
      ),
    ));
  }
}
