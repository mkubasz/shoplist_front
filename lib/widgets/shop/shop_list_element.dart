import 'dart:async';

import 'package:duck_shop/blocs/data_manager_bloc.dart';
import 'package:duck_shop/models/product.dart';
import 'package:duck_shop/widgets/shop/product_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_edit_product.dart';

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
      BlocProvider.of<DataManagerBloc>(context).add(RemoveProduct(data));
    });
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      BlocProvider.of<DataManagerBloc>(context)
          .add(FilterProducts(_selectedIndex == 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.fiber_new), title: Text('Lista')),
          BottomNavigationBarItem(
              icon: Icon(Icons.check), title: Text('Zrobione'))
        ],
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditProduct()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: widget.shopList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: ProductElement(
                  product: widget.shopList[index],
                  remove: () {
                    setState(() {
                      streamController.add(widget.shopList.removeAt(index));
                    });
                  }),
            );
          }),
    );
  }
}
