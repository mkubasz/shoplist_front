import 'package:bloc/bloc.dart';
import 'package:duck_shop/infrastructure/products_group_repository.dart';
import 'package:duck_shop/models/products_group.dart';
import 'package:equatable/equatable.dart';

abstract class ProductsGroupState extends Equatable {
  const ProductsGroupState();

  @override
  List<Object> get props => [];
}

class DefaultProductsGroup extends ProductsGroupState {
  final List<ProductsGroup> productsGroup;
  const DefaultProductsGroup({this.productsGroup});

  @override
  List<Object> get props => [productsGroup];
}

abstract class ProductsGroupEvent extends Equatable {
  const ProductsGroupEvent();

  @override
  List<Object> get props => [];
}

class SetDefaultProductsGroup extends ProductsGroupEvent {}

class AddNewGroup extends ProductsGroupEvent {
  final ProductsGroup productsGroup;
  const AddNewGroup(this.productsGroup);
  @override
  List<Object> get props => [productsGroup];
}

class ProductsGroupBloc extends Bloc<ProductsGroupEvent, ProductsGroupState> {
  ProductsGroupRepository productsGroupRepository;
  ProductsGroupBloc({this.productsGroupRepository});

  @override
  ProductsGroupState get initialState => DefaultProductsGroup();

  @override
  Stream<ProductsGroupState> mapEventToState(ProductsGroupEvent event) async* {
    if (event is SetDefaultProductsGroup) {
      var productsGroup = await productsGroupRepository.getAll();
      yield DefaultProductsGroup(productsGroup: productsGroup);
    }
    if (event is AddNewGroup) {
      await productsGroupRepository.add(event.productsGroup);
      var list = (state as DefaultProductsGroup).productsGroup;
      yield DefaultProductsGroup(productsGroup: list..add(event.productsGroup));
    }
  }
}
