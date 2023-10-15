import 'package:lichi_app/domain/models/product.dart';

abstract class CatalogState {}

class CatalogEmptyState extends CatalogState {}

class CatalogLoadingState extends CatalogState {}

class CatalogLoadedState extends CatalogState {
  final List<Product> products;

  CatalogLoadedState({required this.products});
}

class CatalogErrorState extends CatalogState {}
