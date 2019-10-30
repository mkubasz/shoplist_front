import 'package:duck_shop/blocs/data_manager_bloc.dart';
import 'package:duck_shop/models/product.dart';
import 'package:duck_shop/widgets/expenses/expenses_page.dart';
import 'package:duck_shop/widgets/shop/add_edit_product.dart';
import 'package:duck_shop/widgets/shop/shop_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  int selectedTab = 0;

  Widget _dashboardTab() {
    switch (selectedTab) {
      case 0:
        {
          return BlocBuilder<DataManagerBloc, DataManagerState>(
              builder: (context, state) {
            if (state is DefaultDataManager) {
              return ShopListPage(state.shopItem);
            }
            return ShopListPage([]);
          });
        }
      case 1:
        {
          return ExpensesPage();
        }
      case 2:
        {
          return Container();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista zakupów'),
          actions: <Widget>[
            FlatButton(
              color: Colors.green,
              onPressed: () {},
              child: Text('Sync'),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text("Menu"),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                selected: selectedTab == 0,
                title: Text('Lista Zakupów'),
                onTap: () {
                  setState(() {
                    selectedTab = 0;
                  });
                },
              ),
              ListTile(
                selected: selectedTab == 1,
                title: Text('Wydatki'),
                onTap: () {
                  setState(() {
                    selectedTab = 1;
                  });
                },
              ),
              ListTile(
                selected: selectedTab == 2,
                title: Text('Ustawienia'),
                onTap: () {
                  setState(() {
                    selectedTab = 2;
                  });
                },
              ),
            ],
          ),
        ),
        body: _dashboardTab());
  }
}
