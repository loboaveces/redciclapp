import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:redciclapp/src/bloc/provider2.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:redciclapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:redciclapp/src/states/current_user.dart';

// Importr todas las paginas creadas

import 'package:redciclapp/src/pages/Normativa_page.dart';
import 'package:redciclapp/src/pages/acerca_page.dart';
import 'package:redciclapp/src/pages/acopiadores_page.dart';
import 'package:redciclapp/src/pages/acopiadoresparaaprobar_page.dart';
import 'package:redciclapp/src/pages/aprobar_acopio_page.dart';
import 'package:redciclapp/src/pages/contacto_page.dart';
import 'package:redciclapp/src/pages/denunciaaco_page.dart';
import 'package:redciclapp/src/pages/denunciaeco_page.dart';
import 'package:redciclapp/src/pages/denunciares_page.dart';
import 'package:redciclapp/src/pages/ecoemprendimientosaprobar_page.dart';
import 'package:redciclapp/src/pages/mapping_page/components/mapping.dart';
import 'package:redciclapp/src/pages/inicio_page.dart';
import 'package:redciclapp/src/pages/intro_page.dart';
import 'package:redciclapp/src/pages/login_page.dart';
import 'package:redciclapp/src/pages/mapa_page.dart';
import 'package:redciclapp/src/pages/misregistros_page.dart';
import 'package:redciclapp/src/pages/pedidosaco_page.dart';
import 'package:redciclapp/src/pages/pedidoseco_page.dart';
import 'package:redciclapp/src/pages/pedidosres_page.dart';
import 'package:redciclapp/src/pages/recicladorasaprobar_page.dart';
import 'package:redciclapp/src/pages/resetpass_page.dart';
import 'package:redciclapp/src/pages/settings_page.dart';
import 'package:redciclapp/src/pages/signin_page.dart';
import 'package:redciclapp/src/pages/solicitudes_page.dart';
import 'package:redciclapp/src/pages/splash_page.dart';
import 'package:redciclapp/src/pages/enrutador_page.dart';
import 'package:redciclapp/src/pages/recicladoras_page.dart';
import 'package:redciclapp/src/pages/ecoemprendimientos_page.dart';
import 'package:redciclapp/src/pages/verifica_page.dart';
import 'package:redciclapp/src/pages/vista_acop_page.dart';
import 'package:redciclapp/src/pages/vista_eco_page.dart';
import 'package:redciclapp/src/pages/vista_res_page.dart';
import 'package:redciclapp/src/pages/vista_solicitud.dart';

void main() async {
  // Estas 3 líneas son para que Firebase pueda intearcuar con el Flutter engine.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

  // prefs tiene las preferencias de usuario que son el Token y el email.
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    // Provide2 es para el login, esto hay que revisar y cambiar
    return Provider2(
        child: ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Redciclapp',
        initialRoute: 'splash',
        //Acá están todas las rutas a las páginas de la aplicación
        routes: {
          'mapping': (BuildContext context) => MappingPage(),
          'login': (BuildContext context) => LoginPage(),
          'signin': (BuildContext context) => SigninPage(),
          'splash': (BuildContext context) => ScrollPage(),
          'enrutar': (BuildContext context) => RootPage(),
          'recicladoras': (BuildContext context) => RecicladoraPage(),
          'recicladorasrev': (BuildContext context) => Recicladora2Page(),
          'ecos': (BuildContext context) => EcoemprendimientoPage(),
          'ecosrev': (BuildContext context) => Ecoemprendimiento2Page(),
          'acopiadores': (BuildContext context) => AcopiadorPage(),
          'acopiadoresrev': (BuildContext context) => Acopiador2Page(),
          'inicio': (BuildContext context) => Inicio(),
          'settings': (BuildContext context) => SettingsPage(),
          'verifica': (BuildContext context) => VerificaPage(),
          'reset': (BuildContext context) => ResetPage(),
          'intro': (BuildContext context) => IntroPage(),
          'mapa': (BuildContext context) => MapaPage(),
          'misregistros': (BuildContext context) => MisRegistros(),
          "pedidos": (BuildContext context) => PedidosPage(), //recicladoras
          "pedidoseco": (BuildContext context) =>
              PedidosecoPage(), //ecoemprendimientos
          "pedidosaco": (BuildContext context) =>
              PedidosacoPage(), //acopiadores
          'vistarecicladora': (BuildContext context) => VistaRecicladora(),
          'vistaecoemprendimiento': (BuildContext context) =>
              VistaEcoemprendimiento(),
          'vistaacopiador': (BuildContext context) => VistaAcopiador(),
          'solicitudes': (BuildContext context) => SolicitudesPage(),
          'vistasolicitud': (BuildContext context) => VistaSolicitud(),
          'aprobaciones': (BuildContext context) => Aprobaciones(),
          'denuncias': (BuildContext context) => DenunciaPage(),
          'denunciaseco': (BuildContext context) => DenunciaecoPage(),
          'denunciasaco': (BuildContext context) => DenunciaacoPage(),
          'contacto': (BuildContext context) => ContactoPage(),
          'normativa': (BuildContext context) => NormativaPage(),
          'acercade': (BuildContext context) => AcercaPage(),
        },
      ),
    ));
  }
}
