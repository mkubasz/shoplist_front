import 'package:duck_shop/infrastructure/network_data_provider.dart';
import 'package:duck_shop/models/product.dart';

import 'in_memory_data_provider.dart';

class ShopListRepository {
  InMemoryDataProvider inMemoryDataProvider = InMemoryDataProvider();
  NetworkDataProvider networkDataProvider = NetworkDataProvider();
  Future<List<Product>> getAll() async {
    return inMemoryDataProvider.getAll();
  }

  Future add(Product product) async {
    await inMemoryDataProvider.add(product);
    await networkDataProvider.add(product);
  }

  Future update(Product product) async {
    return inMemoryDataProvider.update(product);
  }

  Future remove(Product product) async {
    return inMemoryDataProvider.remove(product);
  }
}
