// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AdditionRoute.name: (routeData) {
      final args = routeData.argsAs<AdditionRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AdditionPage(productBase: args.productBase),
      );
    },
    BasketRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BasketPage(),
      );
    },
    CatalogRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CatalogPage(),
      );
    },
    ProductRoute.name: (routeData) {
      final args = routeData.argsAs<ProductRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductPage(
          args.product,
          args.id,
        ),
      );
    },
  };
}

/// generated route for
/// [AdditionPage]
class AdditionRoute extends PageRouteInfo<AdditionRouteArgs> {
  AdditionRoute({
    required ProductBase productBase,
    List<PageRouteInfo>? children,
  }) : super(
          AdditionRoute.name,
          args: AdditionRouteArgs(productBase: productBase),
          initialChildren: children,
        );

  static const String name = 'AdditionRoute';

  static const PageInfo<AdditionRouteArgs> page =
      PageInfo<AdditionRouteArgs>(name);
}

class AdditionRouteArgs {
  const AdditionRouteArgs({required this.productBase});

  final ProductBase productBase;

  @override
  String toString() {
    return 'AdditionRouteArgs{productBase: $productBase}';
  }
}

/// generated route for
/// [BasketPage]
class BasketRoute extends PageRouteInfo<void> {
  const BasketRoute({List<PageRouteInfo>? children})
      : super(
          BasketRoute.name,
          initialChildren: children,
        );

  static const String name = 'BasketRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CatalogPage]
class CatalogRoute extends PageRouteInfo<void> {
  const CatalogRoute({List<PageRouteInfo>? children})
      : super(
          CatalogRoute.name,
          initialChildren: children,
        );

  static const String name = 'CatalogRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProductPage]
class ProductRoute extends PageRouteInfo<ProductRouteArgs> {
  ProductRoute({
    required Product? product,
    required int? id,
    List<PageRouteInfo>? children,
  }) : super(
          ProductRoute.name,
          args: ProductRouteArgs(
            product: product,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductRoute';

  static const PageInfo<ProductRouteArgs> page =
      PageInfo<ProductRouteArgs>(name);
}

class ProductRouteArgs {
  const ProductRouteArgs({
    required this.product,
    required this.id,
  });

  final Product? product;

  final int? id;

  @override
  String toString() {
    return 'ProductRouteArgs{product: $product, id: $id}';
  }
}
