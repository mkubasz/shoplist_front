import 'dart:math';

import 'package:duck_shop/blocs/data_manager_bloc.dart';
import 'package:duck_shop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_edit_product.dart';

class ProductElement extends StatefulWidget {
  Product product;
  void Function() remove;
  ProductElement({this.product, this.remove});

  @override
  State<StatefulWidget> createState() => _ProductState();
}

class _ProductState extends State<ProductElement> {
  @override
  void initState() {
    super.initState();
  }

  Map<String, Color> colorCategory = {
    'Owoce': Colors.purple,
    'Warzywa': Colors.amber,
    'Mięso': Colors.red,
    'Inne': Colors.blue
  };

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(UniqueKey().toString()),
      background: Container(color: Colors.red),
      child: new GestureDetector(
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddEditProduct(product: widget.product)),
            );
          },
          child: Stack(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  color: colorCategory[widget.product.category],
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5),
                      bottomLeft: const Radius.circular(5)),
                ),
                height: 52,
                width: 12,
              ),
              Card(
                shape: widget.product.bought
                    ? RoundedRectangleBorder(
                        side: BorderSide(color: Colors.green, width: 2.0),
                        borderRadius: BorderRadius.circular(4.0))
                    : RoundedRectangleBorder(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.check_circle_outline,
                            color: widget.product.bought
                                ? Colors.green
                                : Colors.grey),
                        onPressed: () {
                          setState(() {
                            widget.product.bought = !widget.product.bought;
                            BlocProvider.of<DataManagerBloc>(context)
                                .add(BoughtProduct(widget.product));
                          });
                        },
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Produkt',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${widget.product.name}'),
                      ],
                    ),
                    Flexible(
                        child: Column(
                      children: <Widget>[
                        Text(
                          'Opis',
                          maxLines: null,
                          softWrap: true,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${widget.product.description}'),
                      ],
                    )),
                    Column(
                      children: <Widget>[
                        Text(
                          'Ilosc',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${widget.product.number}'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
      onDismissed: (direction) {
        widget.remove();
      },
    );
  }
}
