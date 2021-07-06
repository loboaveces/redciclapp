import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:redciclapp/src/bloc/provider2.dart';
import 'package:redciclapp/src/states/current_user.dart';

class ResetPage extends StatefulWidget {
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //  CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginform(context),
      ],
    ));
  }

  Widget _loginform(BuildContext context) {
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
                Text('¿Olvidaste tu contraseña?',
                    style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 30.0),
                _crearEmail(),
                SizedBox(height: 30.0),
                _crearBoton(),
                SizedBox(height: 15.0),
                FlatButton(
                  child: Text('<-- Atrás: Iniciar Sesión '),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearEmail() {
    return StreamBuilder(
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
              helperText:
                  'Introduce el correo electrónico en el que te registraste',
              // counterText: snapshot.data,
              helperMaxLines: 3,
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
          ),
        );
      },
    );
  }

  Widget _crearBoton() {
    //formValidStream

    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text("Enviar"),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 0.0,
          color: Color.fromRGBO(34, 181, 115, 1.0),
          textColor: Colors.white,
          onPressed: () {
            _resetear(_emailController.text, context);
          },
        );
      },
    );
  }

  _resetear(String email, BuildContext context) async {
    CurrentUser _currentUser = Provider.of(context, listen: false);

    if (await _currentUser.sendPasswordResetMail(email)) {
      print("se envió");
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Te hemos enviado un mensaje a tu email para que puedas restablecer la contraseña"),
            duration: Duration(seconds: 4)),
      );
    } else {
      print("no se envió");
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text("Cuenta de correo no registrada, intenta nuevamente"),
            duration: Duration(seconds: 4)),
      );
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
