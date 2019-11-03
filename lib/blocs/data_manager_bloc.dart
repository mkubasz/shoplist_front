import 'package:bloc/bloc.dart';
import 'package:duck_shop/infrastructure/shop_list_repository.dart';
import 'package:duck_shop/models/product.dart';
import 'package:equatable/equatable.dart';

abstract class DataManagerState extends Equatable {
  const DataManagerState();

  @override
  List<Object> get props => [];
}

class InitializeDataManager extends DataManagerState {}

class DefaultDataManager extends DataManagerState {
  final List<Product> shopItem;

  DefaultDataManager(this.shopItem);

  @override
  List<Object> get props => [shopItem];
}

abstract class DataManagerEvent extends Equatable {
  const DataManagerEvent();

  @override
  List<Object> get props => [];
}

class SetDefaultDataManager extends DataManagerEvent {}

class AddProduct extends DataManagerEvent {
  final Product product;
  const AddProduct({this.product});
}

class BoughtProduct extends DataManagerEvent {
  final Product product;
  const BoughtProduct(this.product);
}

class UpdateProduct extends DataManagerEvent {
  final Product product;
  const UpdateProduct(this.product);
}

class RemoveProduct extends DataManagerEvent {
  final Product product;
  const RemoveProduct(this.product);
}

class FilterProducts extends DataManagerEvent {
  final bool bought;
  const FilterProducts(this.bought);
}

class SyncData extends DataManagerEvent {}

class DataManagerBloc extends Bloc<DataManagerEvent, DataManagerState> {
  ShopListRepository shopListRepository;

  DataManagerBloc(this.shopListRepository);

  @override
  DataManagerState get initialState => DefaultDataManager([]);

  @override
  Stream<DataManagerState> mapEventToState(DataManagerEvent event) async* {
    if (event is SetDefaultDataManager) {
      var list = await shopListRepository.getAll() ?? [];

      yield DefaultDataManager(list.where((filter) => !filter.bought).toList());
    }
    if (event is AddProduct) {
      var list = (state as DefaultDataManager).shopItem..add(event.product);
      list.sort((p1, p2) => p1.category.compareTo(p2.category));
      shopListRepository.add(event.product);
      yield DefaultDataManager(list);
    }
    if (event is BoughtProduct) {
      await shopListRepository.update(event.product);
      var list = await shopListRepository.getAll();
      list = list.map((item) {
        if (item.id == event.product.id) {
          item.bought = event.product.bought;
        }
        return item;
      }).toList();

      yield DefaultDataManager(
          list.where((p) => p.bought != event.product.bought).toList());
    }
    if (event is UpdateProduct) {
      await shopListRepository.update(event.product);
      yield DefaultDataManager(
          (state as DefaultDataManager).shopItem.map((item) {
        if (item.id == event.product.id) {
          item = event.product;
        }
        return item;
      }).toList());
    }

    if (event is RemoveProduct) {
      await shopListRepository.remove(event.product);
      yield DefaultDataManager((state as DefaultDataManager)
          .shopItem
          .where((item) => item.id != event.product.id)
          .toList());
    }

    if (event is FilterProducts) {
      var list = await shopListRepository.getAll();
      yield DefaultDataManager(
          list.where((item) => item.bought == event.bought).toList());
    }

    if (event is SyncData) {
      var list = await shopListRepository.getAll(sync: true);

      yield DefaultDataManager(
          list..addAll((state as DefaultDataManager).shopItem));
    }
  }
}
