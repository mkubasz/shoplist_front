import 'dart:async';

import 'package:duck_shop/blocs/data_manager_state.dart';
import 'package:duck_shop/models/product.dart';
import 'package:duck_shop/widgets/shop/product_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopListElement extends StatefulWidget {
  List<Product> shopList;

  ShopListElement(this.shopList);

  @override
  State<StatefulWidget> createState() {
    return _ShopListState();
  }
}

class _ShopListState extends State<ShopListElement> {
  StreamController<Product> streamController = StreamController();
  @override
  void initState() {
    super.initState();

    streamController.stream.listen((data) {
      BlocProvider.of<ManagerBloc>(context).add(RemoveProduct(data));
    });
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.shopList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(UniqueKey().toString()),
            background: Container(color: Colors.red),
            child: ProductElement(product: widget.shopList[index]),
            onDismissed: (direction) {
              setState(() {
                streamController.add(widget.shopList.removeAt(index));
              });
            },
          );
        });
  }
}
