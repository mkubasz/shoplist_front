import 'package:duck_shop/blocs/data_manager_state.dart';
import 'package:duck_shop/models/product.dart';
import 'package:duck_shop/widgets/shop/add_edit_product.dart';
import 'package:duck_shop/widgets/shop/shop_list_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    List<String> dupa = ["ania", "barto"];
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista zakupów'),
      ),
      body:
          BlocBuilder<ManagerBloc, DataManagerState>(builder: (context, state) {
        if (state is DefaultDataManager && state.shopItem.isNotEmpty) {
          return ShopListElement(state.shopItem);
        }
        return ListView();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditProduct()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
