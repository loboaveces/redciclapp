import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redciclapp/src/bloc/provider2.dart';
import 'package:redciclapp/src/pages/enrutador_page.dart';
import 'package:redciclapp/src/pages/verifica_page.dart';
import 'package:redciclapp/src/providers/usuario_provider.dart';
import 'package:redciclapp/src/states/current_user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginform(context),
      ],
    ));
  }

  Widget _loginform(BuildContext context) {
    final bloc = Provider2.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(child: Container(height: 180.0)),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0, 5.0),
                      spreadRadius: 3.0),
                ]),
            child: Column(
              children: <Widget>[
                Text('Ingresa tus datos', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 30.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearContrasena(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          FlatButton(
            child: Text('¿No tienes cuenta? --> Crea una cuenta'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'signin'),
          ),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email,
                  color: Color.fromRGBO(34, 181, 115, 1.0)),
              hintText: 'tucorreo@email.com',
              labelText: 'Correo electrónico',
              labelStyle: TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
              helperText: 'Introduce tu correo electrónico',
              // counterText: snapshot.data,
              errorText: snapshot.error,
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
              ),
              border: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
              ),
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearContrasena(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline,
                      color: Color.fromRGBO(34, 181, 115, 1.0)),
                  // hintText: 'nombre.apellido@aldeasinfantiles.org.bo',
                  labelText: 'Contraseña',
                  labelStyle:
                      TextStyle(color: Color.fromRGBO(34, 181, 115, 1.0)),
                  errorText: snapshot.error,
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
                  ),
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(34, 181, 115, 1.0)),
                  ),
                ),
                onChanged: bloc.changePassword,
              ),
            ),
            FlatButton(
              child: Text(
                '¿Olvidaste tu contraseña? --> Restablecer',
                style: TextStyle(
                  fontSize: 11,
                ),
                textAlign: TextAlign.left,
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, 'reset'),
            ),
          ],
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    //formValidStream

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text("Entrar"),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 0.0,
          color: Color.fromRGBO(34, 181, 115, 1.0),
          textColor: Colors.white,
          onPressed: () {
            _loginUser(
                _emailController.text, _passwordController.text, bloc, context);
          },
        );
      },
    );
  }

  _loginUser(String email, String password, LoginBloc bloc,
      BuildContext context) async {
    CurrentUser _currentUser = Provider.of(context, listen: false);
    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    try {
      if (await _currentUser.loginUser(email, password) && info['ok']) {
        _verificar(email, password, _currentUser);
        // Navigator.pushReplacementNamed(context, 'inicio');
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Email o contraseña incorrectos, intenta nuevamente"),
              duration: Duration(seconds: 4)),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void _verificar(
      String email, String password, CurrentUser _currentUser) async {
    try {
      if (await _currentUser.verifica(email, password)) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => RootPage()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => VerificaPage()));
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoredcicla = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(34, 181, 115, 1.0),
        Color.fromRGBO(34, 181, 115, 0.5),
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.2),
      ),
    );

    return Stack(
      children: <Widget>[
        fondoredcicla,
        Positioned(top: 140.0, left: 10.0, child: circulo),
        Positioned(top: 20.0, left: 280.0, child: circulo),
        Positioned(bottom: -20.0, right: -10.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Image(image: AssetImage('assets/hojas.png'), height: 85),
              // Icon(Icons.account_box, color: Colors.white, size: 100.0),
              SizedBox(height: 20.0, width: double.infinity),
              Text(
                'Inicia Sesión',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ],
          ),
        )
      ],
    );
  }
}
