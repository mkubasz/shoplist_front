import 'package:duck_shop/blocs/products_group_data_manager.dart';
import 'package:duck_shop/models/products_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

class AddEditProductsGroup extends StatefulWidget {
  List<ProductsGroup> productsGroup;
  AddEditProductsGroup({this.productsGroup});

  @override
  State<StatefulWidget> createState() {
    return _AddEditProductsGroupState();
  }
}

class _AddEditProductsGroupState extends State<AddEditProductsGroup> {
  Tuple2<String, String> productsGroupValue;
  String productsGroupName;
  @override
  void initState() {
    productsGroupValue =
        Tuple2(widget.productsGroup.first.id, widget.productsGroup.first.name);
    productsGroupName = widget.productsGroup.first.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj/edytuj'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              DropdownButton<String>(
                value: productsGroupValue.item2,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {});
                },
                items: widget.productsGroup
                    .map<DropdownMenuItem<String>>((ProductsGroup value) {
                  return DropdownMenuItem<String>(
                    value: value.name,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
              TextFormField(
                initialValue: productsGroupValue.item2 ?? '',
                decoration: InputDecoration(hintText: "Produkt"),
                onChanged: (value) {
                  setState(() {
                    productsGroupName = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      BlocProvider.of<ProductsGroupBloc>(context).add(
                          AddNewGroup(ProductsGroup(
                              name: productsGroupName, id: Uuid().v1())));
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text('Zaakceptuj'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
