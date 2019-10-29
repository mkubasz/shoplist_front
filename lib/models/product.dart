import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String id;
  String name;
  String description = 'Brak';
  String image = '';
  String category;
  int number;
  bool bought;

  Product(
      {this.category,
      this.id,
      this.name,
      this.description,
      this.number,
      this.bought = false});

  @override
  List<Object> get props => [id, name, description, number, bought];

  Product.fromMappedJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        description = json['description'],
        category = json['category'],
        number = json['number'],
        bought = json['bought'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'description': description,
        'category': category,
        'number': number,
        'bought': bought
      };
}
