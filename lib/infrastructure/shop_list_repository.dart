import 'dart:convert';

import 'package:duck_shop/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'in_memory_data_provider.dart';

class ShopListRepository {
  InMemoryDataProvider inMemoryDataProvider = InMemoryDataProvider();

  Future<List<Product>> getAll() async {
    return inMemoryDataProvider.getAll();
  }

  Future add(Product product) async {
    return inMemoryDataProvider.add(product);
  }

  Future update(Product product) async {
    return inMemoryDataProvider.update(product);
  }

  Future remove(Product product) async {
    return inMemoryDataProvider.remove(product);
  }
}
