import 'package:redciclapp/src/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:autotes_sos_co19/src/bloc/provider.dart';
// import 'package:autotes_sos_co19/src/utils/utils.dart';

class SigninPage extends StatefulWidget {
  // final usuarioProvider = new UsuarioProvider();
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _signUpUser(String email, String password, BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      if (await _currentUser.signUpUser(email, password)) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Cuenta creada, ahora inicia sesión, redirigiendo..."),
              duration: Duration(seconds: 4)),
        );
        Navigator.pushReplacementNamed(context, 'login');
      }
    } catch (e) {
      print(e);
    }
  }

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
    // final bloc =Provider.of(context);
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
                _crearEmail(),
                SizedBox(height: 30.0),
                _crearContrasena(),
                SizedBox(height: 30.0),
                _repiteContrasena(),
                SizedBox(height: 30.0),
                _crearBoton(),
              ],
            ),
          ),
          FlatButton(
            child: Text('¿Ya tienes cuenta? --> Inicia sesión'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }

  Widget _crearEmail() {
    return StreamBuilder(
      // stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email,
                  color: Color.fromRGBO(34, 181, 115, 1.0)),
              hintText: 'ejemplo@email.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
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

            // onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearContrasena() {
    return StreamBuilder(
      // stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline,
                  color: Color.fromRGBO(34, 181, 115, 1.0)),
              // hintText: 'Mínimo 1 letra mayúscula
              // '/n' Mínimo 1 letra minúscula '/n' Mínimo 1 número '/n' Mínimo 1 caracter especial /n Caracteres permitidos: ! @ # & * ~ ',
              labelText: 'Contraseña',
              counterText: snapshot.data,
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
            // onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _repiteContrasena() {
    return StreamBuilder(
      // stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline,
                  color: Color.fromRGBO(34, 181, 115, 1.0)),
              // hintText: 'Mínimo 1 letra mayúscula
              // '/n' Mínimo 1 letra minúscula '/n' Mínimo 1 número '/n' Mínimo 1 caracter especial /n Caracteres permitidos: ! @ # & * ~ ',
              labelText: 'Repite la Contraseña',
              counterText: snapshot.data,
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
            // onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton() {
    //formValidStream

    return StreamBuilder(
        // stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text("Crear cuenta"),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 0.0,
          color: Color.fromRGBO(34, 181, 115, 1.0),
          textColor: Colors.white,
          onPressed: () {
            if (_passwordController.text.length >= 6) {
              if (_passwordController.text == _confirmPasswordController.text) {
                _signUpUser(
                    _emailController.text, _passwordController.text, context);
              } else {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Las contraseñas no coinciden"),
                      duration: Duration(seconds: 2)),
                );
              }
            } else {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        "La contraseña debe tener por lo menos 6 caracteres "),
                    duration: Duration(seconds: 2)),
              );
            }
          });
    });
  }
}

Widget _crearFondo(BuildContext context) {
  final size = MediaQuery.of(context).size;

  final fondoSOS = Container(
    height: size.height * 0.4,
    width: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
      Color.fromRGBO(34, 181, 115, 1.0),
      Color.fromRGBO(34, 181, 115, 0.6),
    ])),
  );

  final circulo = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Color.fromRGBO(255, 255, 255, 0.1),
    ),
  );

  return Stack(
    children: <Widget>[
      fondoSOS,
      Positioned(top: 120.0, left: 30.0, child: circulo),
      Positioned(top: -10.0, left: 240.0, child: circulo),
      Positioned(bottom: -50.0, right: -10.0, child: circulo),
      Container(
        padding: EdgeInsets.only(top: 80.0),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/hojas.png'), height: 85),
            // Icon(Icons.person_pin, color: Colors.white, size: 100.0),
            SizedBox(height: 20.0, width: double.infinity),
            Text(
              'Crear cuenta',
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
          ],
        ),
      )
    ],
  );
}
