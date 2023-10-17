import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/const/my_string.dart';
import 'package:lichi_app/domain/models/product.dart';
import 'package:lichi_app/ui/bloc/catalog/catalog_bloc.dart';
import 'package:lichi_app/ui/bloc/catalog/catalog_event.dart';

class TransformProduct {
  static Product transformSingleProduct(dynamic value) {
    var aProduct = value['api_data']['aData'];
    var htmlDescription = aProduct['descriptions']['html'];
    aProduct['description'] = htmlDescription;
    var current = aProduct['colors']['current'];
    aProduct['current'] = current;
    var other = aProduct['colors']['other'];
    aProduct['other'] = other;
    return Product.fromJson(aProduct);
  }

  static List<Product> transformListProduct(dynamic value) {
    var aProducts = value['api_data']['aProduct'];
    List<Product> valueProducts = (aProducts as List<dynamic>).map((aProduct) {
      var htmlDescription = aProduct['descriptions']['html'];
      aProduct['description'] = htmlDescription;
      var current = aProduct['colors']['current'];
      aProduct['current'] = current;
      var other = aProduct['colors']['other'];
      aProduct['other'] = other;
      return Product.fromJson(aProduct);
    }).toList();
    return valueProducts;
  }

  static void selectWid(BuildContext context) {
    showGeneralDialog(
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierDismissible: true,
      barrierColor: const Color(0xFFF6F6F6).withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height * 0.45,
                margin: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Material(
                      child: Text(
                        "Выберите категорию",
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Material(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          context
                              .read<CatalogBloc>()
                              .add(CatalogLoadingEvent(cloth: NOVELTY));
                        },
                        child: const Text(
                          "Новинки",
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                        ),
                      ),
                    ),
                    Material(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          context
                              .read<CatalogBloc>()
                              .add(CatalogLoadingEvent(cloth: DRESSES));
                        },
                        child: const Text(
                          "Платья",
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Material(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          context
                              .read<CatalogBloc>()
                              .add(CatalogLoadingEvent(cloth: SKIRTS));
                        },
                        child: const Text(
                          "Юбки",
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Material(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          context
                              .read<CatalogBloc>()
                              .add(CatalogLoadingEvent(cloth: SHOES));
                        },
                        child: const Text(
                          "Обувь",
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
    // showGeneralDialog(
    //   context: context,
    //   pageBuilder: (_, __, ___) {
    //     return SafeArea(child: Text("Custom"));
    //   },
    //   transitionBuilder: (_, anim, __, child) {
    //     return SlideTransition(
    //       position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
    //       child: child,
    //     );
    //   },
    //   transitionDuration: Duration(milliseconds: 700),
    // );
  }
}
