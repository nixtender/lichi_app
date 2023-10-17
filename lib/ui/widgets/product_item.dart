import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lichi_app/domain/models/product.dart';
import 'package:lichi_app/internal/hex_color.dart';
import 'package:lichi_app/internal/space_price.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  List<String> allColors = <String>[];
  PageController pageController = PageController();

  ProductItem({super.key, required this.product}) {
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
        Stack(
          children: [
            Container(
              height: 260,
              child: PageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (pageContext, pageIndex) {
                  return CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      child: SizedBox(),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 260,
                    imageUrl: product.photos[pageIndex].big,
                    imageBuilder: (_, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: product.photos.length,
              ),
            ),
            Container(
                height: 260,
                padding: EdgeInsets.all(15),
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0x77FFFFFF)),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: product.photos.length,
                    effect: SlideEffect(
                        radius: 6,
                        dotHeight: 6,
                        dotWidth: 6,
                        spacing: 4,
                        dotColor: Colors.white,
                        activeDotColor: Colors.black),
                  ),
                ))
          ],
        ),
        const SizedBox(
          height: 17,
        ),
        Text(
          "${SpacePrice.getSpacePrice(product.price)} руб.",
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
