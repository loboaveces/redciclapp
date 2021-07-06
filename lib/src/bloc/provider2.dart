import 'package:redciclapp/src/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
export 'package:redciclapp/src/bloc/login_bloc.dart';

class Provider2 extends InheritedWidget {
  static Provider2 _instancia;
  factory Provider2({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider2._internal(key: key, child: child);
    }

    return _instancia;
  }

  final loginbloc = LoginBloc();

  Provider2._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider2>().loginbloc;
  }
}
