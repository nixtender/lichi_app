import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lichi_app/domain/models/product.dart';
import 'package:lichi_app/internal/hex_color.dart';

@RoutePage()
class ProductPage extends StatelessWidget {
  final Product product;
  List<String> allColors = <String>[];

  ProductPage({super.key, required this.product}) {
    allColors.add(product.current.value);
    product.other.forEach((element) {
      allColors.add(element.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => Container(
              child: SizedBox(),
            ),
            // width: MediaQuery.of(context).size.width,
            // height: 260,
            imageUrl: product.photos[0].big,
          ),
          const SizedBox(
            height: 27,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              product.name,
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: allColors
                .map<Widget>((colorCloth) => Container(
                      width: 18,
                      height: 18,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: ShapeDecoration(
                        color: Color(HexColor.getIntColor(colorCloth)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            product.current.name,
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 13,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 22,
          ),
          Text(
            "${product.price} руб.",
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(500, 71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                backgroundColor: Colors.black,
              ),
              child: Text(
                "Добавить в корзину",
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Html(
              data: product.description,
              style: {
                "p": Style(lineHeight: LineHeight(1.5)),
                "ul": Style(
                    lineHeight: LineHeight(1.5),
                    padding: HtmlPaddings(left: HtmlPadding(15)))
              },
            ),
          ),
        ],
      ),
    );
  }
}
