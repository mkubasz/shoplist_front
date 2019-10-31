import 'dart:convert';

import 'package:duck_shop/models/product.dart';
import 'package:http/http.dart' as http;

class NetworkDataProvider {
  Future<List<Product>> getAll() async {
    var url = 'http://10.0.2.2:8000/products';

    var response = await http.get(url);
    List<Product> products = List();
    for (var product in json.decode(response.body)) {
      products.add(Product.fromMappedJson(json.decode(product)));
    }
    return products;
  }

  Future add(Product product) async {
    var url = 'http://10.0.2.2:8000/product/create';
    var jsonProduct = product.toJson();
    var response = await http.post(url, body: json.encode(jsonProduct));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Future update(Product product) async {}

  Future remove(Product product) async {}
}
