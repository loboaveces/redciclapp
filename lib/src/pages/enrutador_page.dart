import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// //import 'package:redciclapp/src/pages/home_page.dart';
// import 'package:redciclapp/src/pages/inicio_page.dart';
import 'package:redciclapp/src/pages/intro_page.dart';
import 'package:redciclapp/src/pages/login_page.dart';
import 'package:redciclapp/src/states/current_user.dart';

enum AuthStatus {
  notloggedin,
  loggedIn,
}

class RootPage extends StatefulWidget {
  RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notloggedin;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    //Obtener Estado, verificar usuario, establecer Authstatus
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _salida = await _currentUser.onStartup();
    if (_salida == 'success') {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.notloggedin:
        retVal = LoginPage();
        break;
      case AuthStatus.loggedIn:
        retVal = IntroPage();
        break;
    }
    return retVal;
  }
}
