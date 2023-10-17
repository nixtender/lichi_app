import 'package:flutter/material.dart';
import 'package:lichi_app/domain/models/product.dart';

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
      barrierColor: Color(0xFFF6F6F6).withOpacity(0.3),
      transitionDuration: Duration(milliseconds: 400),
      context: context,
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height * 0.45,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
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
                        onTap: () {},
                        child: Text(
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
                        onTap: () {},
                        child: Text(
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
                        onTap: () {},
                        child: Text(
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
                        onTap: () {},
                        child: Text(
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
                margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            );
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
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
