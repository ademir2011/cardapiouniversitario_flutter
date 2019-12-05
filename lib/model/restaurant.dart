import 'package:cardapiouniversitario/model/product.dart';

class Restaurant {
  String nome;
  String descricao;
  List<Product> produtos;
  String pathImage;

  Restaurant({this.nome, this.produtos});
}
