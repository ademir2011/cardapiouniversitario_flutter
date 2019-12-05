import 'dart:convert';

import 'package:cardapiouniversitario/model/product.dart';
import 'package:cardapiouniversitario/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Restaurant restaurant;
var page;

class Description extends StatefulWidget {
  Description(restaurantTemp, index) {
    page = index + 2;
    restaurant = restaurantTemp;
  }

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  List<Product> products = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<dynamic> loadJson(url) async {
    var response = await http.get(url);
    return response.statusCode == 200 ? jsonDecode(response.body) : null;
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
            'https://spreadsheets.google.com/feeds/cells/1xMY4iVtKMXp5GEPaI6qrZhWaKLnHItDx0rJyuHRSm5g/${page}/public/full?alt=json')
        .then((data) {
      setState(() {
        var contador = 3;
        products = [];
        print("pagina - ${page} tamanho ${data['feed']['entry'].length}");
        for (var j = 3; j < data['feed']['entry'].length; j += 3) {
          products.add(
            Product(
                nome: data['feed']['entry'][contador++]['gs\$cell']['\$t'],
                preco: data['feed']['entry'][contador++]['gs\$cell']['\$t'],
                categoria: data['feed']['entry'][contador++]['gs\$cell']
                    ['\$t']),
          );
          // print(data['feed']['entry'][contador++]['gs\$cell']['\$t']);
          // print(data['feed']['entry'][contador++]['gs\$cell']['\$t']);
          // print(data['feed']['entry'][contador++]['gs\$cell']['\$t']);
        }
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
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return buildListTile(index);
          },
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar();
  }

  Widget buildListTile(index) {
    return ListTile(
        leading: Icon(
          Icons.account_balance,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              products[index].nome,
            ),
            Text(
              products[index].preco,
            ),
          ],
        ));
  }
}
