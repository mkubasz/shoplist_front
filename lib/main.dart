import 'package:duck_shop/blocs/dashboard_state.dart';
import 'package:duck_shop/blocs/data_manager_state.dart';
import 'package:duck_shop/infrastructure/shop_list_repository.dart';
import 'package:duck_shop/widgets/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(BlocProvider<ManagerBloc>(
      builder: (context) =>
          ManagerBloc(ShopListRepository())..add(SetDefaultDataManager()),
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
