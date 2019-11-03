import 'package:equatable/equatable.dart';

class ProductsGroup extends Equatable {
  String id;
  String name;

  ProductsGroup({this.id, this.name});

  @override
  List<Object> get props => [id, name];

  ProductsGroup.fromMappedJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
