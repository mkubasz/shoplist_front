import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String id;
  String name;
  String session = "Mateusz";
  String description = 'Brak';
  String image = '';
  String category;
  String projectsGroupID;
  int number;
  bool bought;

  Product(
      {this.category,
      this.id,
      this.name,
      this.description,
      this.number,
      this.projectsGroupID,
      this.bought = false});

  @override
  List<Object> get props => [
        id,
        session,
        name,
        description,
        number,
        bought,
        session,
        image,
        projectsGroupID
      ];

  Product.fromMappedJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        description = json['description'],
        category = json['category'],
        number = json['number'],
        bought = json['bought'],
        image = json['image'],
        projectsGroupID = json['projectsGroupID'],
        session = json['session'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'description': description,
        'category': category,
        'number': number,
        'bought': bought,
        'image': image,
        'session': session,
        'projectsGroupID': projectsGroupID
      };
}
