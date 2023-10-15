import 'package:lichi_app/domain/models/product.dart';

abstract class CatalogState {}

class CatalogEmptyState extends CatalogState {}

class CatalogLoadingState extends CatalogState {}

class CatalogLoadedState extends CatalogState {
  final Product product;

  CatalogLoadedState({required this.product});
}

class CatalogErrorState extends CatalogState {}
