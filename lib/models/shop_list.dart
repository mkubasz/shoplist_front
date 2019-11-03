import 'package:duck_shop/models/products_group.dart';
import 'package:equatable/equatable.dart';

class ShopList extends Equatable {
  List<ProductsGroup> productsGroup;
  @override
  List<Object> get props => [productsGroup];
}
