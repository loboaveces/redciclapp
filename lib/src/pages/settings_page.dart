import 'package:flutter/material.dart';
import 'package:redciclapp/src/widgets/menu_widget.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes"),
      ),
      drawer: MenuWidget(),
      body: Center(
        child: Text("Ajustes Page"),
      ),
    );
  }
}
