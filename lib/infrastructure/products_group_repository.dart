import 'dart:convert';

import 'package:duck_shop/models/products_group.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ProductsGroupRepository {
  Future<List<ProductsGroup>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("productsGroup")) {
      var _id = Uuid().v1();
      prefs.setStringList("productsGroup", []);
      prefs.commit();
      await this.add(ProductsGroup(name: "Domyślna grupa", id: _id));
      return [ProductsGroup(name: "Domyślna grupa", id: _id)];
    }

    List<ProductsGroup> list = prefs
        .getStringList("productsGroup")
        .map((item) => ProductsGroup.fromMappedJson(json.decode(item)))
        .toList();
    return list;
  }

  Future add(ProductsGroup productsGroup) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList("productsGroup");
    list.add(json.encode(productsGroup.toJson()));
    prefs.setStringList("productsGroup", list);
  }
}
