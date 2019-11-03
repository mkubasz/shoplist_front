import 'package:duck_shop/blocs/dashboard_bloc.dart';
import 'package:duck_shop/blocs/data_manager_bloc.dart';
import 'package:duck_shop/blocs/products_group_data_manager.dart';
import 'package:duck_shop/blocs/settings_bloc.dart';
import 'package:duck_shop/infrastructure/products_group_repository.dart';
import 'package:duck_shop/infrastructure/shop_list_repository.dart';
import 'package:duck_shop/widgets/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'infrastructure/settings_repository.dart';

void main() => runApp(MultiBlocProvider(
      providers: [
        BlocProvider<DataManagerBloc>(
            builder: (context) => DataManagerBloc(ShopListRepository())
              ..add(SetDefaultDataManager())),
        BlocProvider<ProductsGroupBloc>(
          builder: (context) => ProductsGroupBloc(
              productsGroupRepository: ProductsGroupRepository())
            ..add(SetDefaultProductsGroup()),
        ),
        BlocProvider<SettingsBloc>(
            builder: (context) =>
                SettingsBloc(settingsRepository: SettingsRepository())
                  ..add(SetDefaultSettings())),
      ],
      child: App(),
    ));

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Duck Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<DashboardBloc>(
        builder: (context) => DashboardBloc(),
        child: DashboardPage(),
      ),
    );
  }
}
