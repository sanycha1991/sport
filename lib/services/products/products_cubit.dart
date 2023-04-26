import 'package:bloc/bloc.dart';

import 'package:sport/extensions/imports.dart';
import 'package:sport/services/products/models/product.dart';
import 'package:sport/services/products/products_repository.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  ProductsLoaded({
    required this.products,
  });
}

class ProductsFailed extends ProductsState {
  String message;
  ProductsFailed({
    required this.message,
  });
}

class ProductsCubit extends Cubit<ProductsState> {
  ProductsRepository repository;
  ProductsCubit({
    required this.repository,
  }) : super(ProductsInitial());

  void fetchProducts() async {
    try {
      emit(ProductsLoading());
      List<Product> data = await repository.$getProducts;
      if (data.isEmpty) {
        emit(ProductsFailed(message: 'Empty data'));
        return;
      }

      emit(ProductsLoaded(products: data));
    } catch (e, line) {
      dd([e, line]);
      emit(ProductsFailed(message: e.toString()));
    }
  }
}
