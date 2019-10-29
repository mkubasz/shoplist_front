import 'dart:convert';

import 'package:duck_shop/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InMemoryDataProvider {
  Future<List<Product>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Product> list = List();
    prefs.getKeys().forEach((key) {
      var element = prefs.getString(key);
      if (element.isNotEmpty) {
        list.add(Product.fromMappedJson(json.decode(element)));
      }
    });

    return list;
  }

  Future add(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(product.id, json.encode(product.toJson()));
  }

  Future update(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(product.id)) {
      prefs.remove(product.id);
      prefs.commit();
      prefs.setString(product.id, json.encode(product.toJson()));
    }
  }

  Future remove(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(product.id)) {
      prefs.remove(product.id);
    }
  }
}
