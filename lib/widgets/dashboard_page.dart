import 'package:duck_shop/blocs/data_manager_bloc.dart';
import 'package:duck_shop/blocs/products_group_data_manager.dart';
import 'package:duck_shop/blocs/settings_bloc.dart';
import 'package:duck_shop/models/settings.dart';
import 'package:duck_shop/widgets/expenses/expenses_page.dart';
import 'package:duck_shop/widgets/settings/settings_page.dart';
import 'package:duck_shop/widgets/shop/shop_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return BlocBuilder<ProductsGroupBloc, ProductsGroupState>(
              builder: (context, state) {
            if (state is DefaultProductsGroup) {
              return ShopListPage(state.productsGroup);
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
          return BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
            if (state is DefaultSettings) {
              return SettingsPage(settings: state.settings);
            }
            return SettingsPage(
              settings: Settings(),
            );
          });
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
              onPressed: () {
                setState(() {
                  BlocProvider.of<DataManagerBloc>(context).add(SyncData());
                });
              },
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
