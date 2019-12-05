import 'dart:convert';

import 'package:cardapiouniversitario/model/product.dart';
import 'package:cardapiouniversitario/model/restaurant.dart';
import 'package:cardapiouniversitario/ui/description.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Restaurant> restaurants = [];

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  dataPopulate(data) {
    restaurants = [];

    for (var i = 1; i < data['feed']['entry'].length; i++) {
      print(data['feed']['entry'][i]['gs\$cell']['\$t']);
      restaurants.add(
        Restaurant(
          nome: data['feed']['entry'][i]['gs\$cell']['\$t'],
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  Future<Null> loadData() async {
    //Carregando dados dos restaurantes
    return await loadJson(
            'https://spreadsheets.google.com/feeds/cells/1xMY4iVtKMXp5GEPaI6qrZhWaKLnHItDx0rJyuHRSm5g/1/public/full?alt=json')
        .then((data) {
      setState(() {
        dataPopulate(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: loadData,
        child: buildBody(context),
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      actions: <Widget>[],
    );
  }

  Future<dynamic> loadJson(url) async {
    var response = await http.get(url);
    return response.statusCode == 200 ? jsonDecode(response.body) : null;
  }

  Widget buildBody(context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.account_balance),
          title: Text(restaurants[index].nome),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Description(restaurants[index], index),
              ),
            );
          },
        );
      },
    );
  }
}
