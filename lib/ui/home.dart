import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }
}

Widget buildAppBar() {
  return AppBar(
    actions: <Widget>[],
  );
}

Widget buildBody() {
  return ListView(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.accessibility_new),
        title: Text('Teste 1'),
      ),
      ListTile(
        leading: Icon(Icons.accessibility_new),
        title: Text('Teste 2'),
      ),
    ],
  );
}
