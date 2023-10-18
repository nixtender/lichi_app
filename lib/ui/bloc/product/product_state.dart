import 'package:lichi_app/domain/models/product.dart';

abstract class ProductState {}

class ProductEmptyState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  Product? product;

  ProductLoadedState([this.product]);
}

class ProductErrorState extends ProductState {}
