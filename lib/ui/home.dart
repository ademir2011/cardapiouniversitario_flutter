import 'dart:convert';

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

  Future<dynamic> loadJson(url) async {
    var response = await http.get(url);
    return response.statusCode == 200 ? jsonDecode(response.body) : null;
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
      title: Text("Cardapio Universitario"),
    );
  }

  Widget buildBody(context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return buildListTile(index);
      },
    );
  }

  Widget buildListTile(index) {
    return ListTile(
      leading: Icon(Icons.account_balance),
      title: Text(restaurants[index].nome),
      subtitle: Row(
        children: <Widget>[
          Icon(
            Icons.star,
            size: 15.0,
            color: Colors.yellow,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "4.2",
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Description(restaurants[index], index),
          ),
        );
      },
    );
  }
}
