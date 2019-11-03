import 'dart:async';

import 'package:duck_shop/blocs/data_manager_bloc.dart';
import 'package:duck_shop/blocs/products_group_data_manager.dart';
import 'package:duck_shop/models/product.dart';
import 'package:duck_shop/models/products_group.dart';
import 'package:duck_shop/widgets/shop/add_edit_products_group.dart';
import 'package:duck_shop/widgets/shop/product_element.dart';
import 'package:duck_shop/widgets/shop/products_group_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'add_edit_product.dart';

class ShopListPage extends StatefulWidget {
  List<ProductsGroup> shopList = [];

  ShopListPage(this.shopList);

  @override
  State<StatefulWidget> createState() {
    return _ShopListState();
  }
}

class _ShopListState extends State<ShopListPage> {
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
      floatingActionButton: SpeedDial(
        child: Icon(Icons.library_add),
        children: [
          SpeedDialChild(
              child: Icon(Icons.add),
              label: "Produkt",
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BlocBuilder<ProductsGroupBloc, ProductsGroupState>(
                              builder: (context, state) {
                                if (state is DefaultProductsGroup) {
                                  return AddEditProduct(
                                      productsGroup: state.productsGroup);
                                } else {
                                  return AddEditProduct();
                                }
                              },
                            )),
                  )),
          SpeedDialChild(
              child: Icon(Icons.list),
              label: "Nowa grupa",
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BlocBuilder<ProductsGroupBloc, ProductsGroupState>(
                              builder: (context, state) {
                                if (state is DefaultProductsGroup) {
                                  return AddEditProductsGroup(
                                      productsGroup: state.productsGroup);
                                } else {
                                  return AddEditProductsGroup();
                                }
                              },
                            )),
                  ))
        ],
      ),
      body: widget.shopList?.isEmpty ?? true
          ? ListView()
          : ListView.builder(
              itemCount: widget.shopList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ProductsGroupElement(
                    productsGroup: widget.shopList[index],
                  ),
                );
              }),
    );
  }
}
