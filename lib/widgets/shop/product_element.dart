import 'dart:math';

import 'package:duck_shop/blocs/data_manager_state.dart';
import 'package:duck_shop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductElement extends StatefulWidget {
  Product product;
  ProductElement({this.product});

  @override
  State<StatefulWidget> createState() => _ProductState();
}

class _ProductState extends State<ProductElement> {
  MaterialColor color;
  @override
  void initState() {
    color = widget.product.bought ? Colors.green : Colors.grey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.check_circle_outline, color: color),
            onPressed: () {
              setState(() {
                widget.product.bought = !widget.product.bought;
//                  BlocProvider.of<ManagerBloc>(context)
//                      .add(BoughtProduct(widget.product));
                this.color = widget.product.bought ? Colors.green : Colors.grey;
              });
            },
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
          Column(
            children: <Widget>[
              Text(
                'Opis',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${widget.product.description}'),
            ],
          ),
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
    );
  }
}
