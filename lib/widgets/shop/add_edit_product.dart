import 'dart:io';

import 'package:duck_shop/blocs/data_manager_bloc.dart';
import 'package:duck_shop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddEditProduct extends StatefulWidget {
  Product product;
  AddEditProduct({this.product});

  @override
  State<StatefulWidget> createState() {
    return _AddEditProductState();
  }
}

class _AddEditProductState extends State<AddEditProduct> {
  String dropdownValue = 'Owoce';
  Product _product;
  bool editable = false;
  File _image;

  @override
  void initState() {
    editable = widget.product != null;
    _product = widget.product ??
        Product(id: Uuid().v1(), number: 1, category: 'Owoce');
    dropdownValue = _product.category;
    super.initState();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
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
              TextFormField(
                initialValue: _product.name ?? '',
                decoration: InputDecoration(hintText: "Produkt"),
                onChanged: (value) {
                  setState(() {
                    _product.name = value;
                  });
                },
              ),
              TextFormField(
                initialValue: _product.description ?? '',
                decoration: InputDecoration(hintText: "Opis"),
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                onChanged: (value) {
                  setState(() {
                    _product.description = value;
                  });
                },
              ),
              TextFormField(
                initialValue: _product.number?.toString() ?? '1',
                decoration: InputDecoration(hintText: "Ilość"),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _product.number = int.parse(value);
                  });
                },
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    _product.category = newValue;
                  });
                },
                items: <String>['Owoce', 'Warzywa', 'Mięso', 'Inne']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Center(
                child: _image == null
                    ? _product.image != ''
                        ? Image.file((File(_product.image)))
                        : Text('Brak zdjęcia')
                    : Image.file(_image),
              ),
              FlatButton(
                onPressed: getImage,
                child: Icon(Icons.add_a_photo),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      if (_image != null) {
                        _product.image = _image.path;
                      }
                      BlocProvider.of<DataManagerBloc>(context).add(editable
                          ? UpdateProduct(_product)
                          : AddProduct(_product));
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
