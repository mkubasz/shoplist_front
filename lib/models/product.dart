import 'package:duck_shop/models/product_category.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Product extends Equatable {
  String id;
  String name;
  String description;
  String image;
  ProductCategory category;
  int number;
  bool bought;

  Product(
      {this.id, this.name, this.description, this.number, this.bought = false});

  @override
  List<Object> get props => [id, name, description, number, bought];
}
