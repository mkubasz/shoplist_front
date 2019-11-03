import 'dart:async';

import 'package:duck_shop/blocs/data_manager_bloc.dart';
import 'package:duck_shop/models/product.dart';
import 'package:duck_shop/models/products_group.dart';
import 'package:duck_shop/widgets/shop/product_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsGroupElement extends StatefulWidget {
  ProductsGroup productsGroup;
  ProductsGroupElement({this.productsGroup});
  @override
  State<StatefulWidget> createState() {
    return _ProductsGroupState();
  }
}

class _ProductsGroupState extends State<ProductsGroupElement> {
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataManagerBloc, DataManagerState>(
        builder: (context, state) {
      if (state is DefaultDataManager) {
        var filterData = state.shopItem
            .where((f) => f.projectsGroupID == widget.productsGroup.id)
            .toList();
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  widget.productsGroup?.name,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 100,
                ),
                Text(
                  "${filterData.length} Elementy",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: filterData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: ProductElement(
                        product: filterData[index],
                        remove: () {
                          setState(() {
                            streamController.add(filterData.removeAt(index));
                          });
                        }),
                  );
                })
          ],
        );
      }
      return Container();
    });
  }
}
