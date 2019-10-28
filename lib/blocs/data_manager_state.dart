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
  const AddProduct(this.product);
}

class BoughtProduct extends DataManagerEvent {
  final Product product;
  const BoughtProduct(this.product);
}

class RemoveProduct extends DataManagerEvent {
  final Product product;
  const RemoveProduct(this.product);
}

class ManagerBloc extends Bloc<DataManagerEvent, DataManagerState> {
  ShopListRepository shopListRepository;

  ManagerBloc(this.shopListRepository);

  @override
  DataManagerState get initialState => InitializeDataManager();

  @override
  Stream<DataManagerState> mapEventToState(DataManagerEvent event) async* {
    if (event is SetDefaultDataManager) {
      var list = await shopListRepository.getAll() ?? [];
      yield DefaultDataManager(list);
    }
    if (event is AddProduct) {
      var list = (state as DefaultDataManager).shopItem..add(event.product);
      shopListRepository.add(event.product);
      yield DefaultDataManager(list);
    }
    if (event is BoughtProduct) {
      await shopListRepository.update(event.product);
      yield DefaultDataManager(
          (state as DefaultDataManager).shopItem.map((item) {
        if (item.id == event.product.id) {
          item.bought = event.product.bought;
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
  }
}
