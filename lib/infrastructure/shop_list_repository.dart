import 'package:duck_shop/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ShopListRepository {
  Future<List<Product>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Product> list = List();
    prefs.getKeys().forEach((key) {
      var element = prefs.getStringList(key);
      if (element.isNotEmpty) {
        list.add(Product(
            id: key,
            name: element[0],
            description: element[1],
            bought: element[2] == 'true',
            number: int.parse(element[3])));
      }
    });

    return list;
  }

  Future add(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(product.id, [
      product.name,
      product.description,
      product.bought.toString(),
      product.number.toString()
    ]);
  }

  Future update(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(product.id)) {
      prefs.remove(product.id);
      prefs.commit();
      prefs.setStringList(product.id, [
        product.name,
        product.description,
        product.bought.toString(),
        product.number.toString()
      ]);
    }
  }

  Future remove(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(product.id)) {
      prefs.remove(product.id);
    }
  }
}
