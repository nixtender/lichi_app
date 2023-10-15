import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lichi_app/domain/models/product.dart';
import 'package:lichi_app/internal/hex_color.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  List<String> allColors = <String>[];

  ProductItem({required this.product}) {
    allColors.add(product.current.value);
    product.other.forEach((element) {
      allColors.add(element.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedNetworkImage(
          placeholder: (context, url) => CircularProgressIndicator(),
          width: MediaQuery.of(context).size.width,
          height: 250,
          imageUrl: product.photos[0].big,
          imageBuilder: (_, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 17,
        ),
        Text(
          "${product.price} руб.",
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          product.name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: allColors
              .map<Widget>((colorCloth) => Container(
                    width: 10.5,
                    height: 10.5,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: ShapeDecoration(
                      color: Color(HexColor.getIntColor(colorCloth)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
