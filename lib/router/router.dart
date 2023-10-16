import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lichi_app/domain/models/product.dart';
import 'package:lichi_app/ui/roots/pages/catalog_page.dart';
import 'package:lichi_app/ui/roots/pages/product_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CatalogRoute.page, path: '/'),
        AutoRoute(page: ProductRoute.page),
      ];
}
