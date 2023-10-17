import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lichi_app/data/services/data_service.dart';
import 'package:lichi_app/domain/models/product.dart';
import 'package:lichi_app/domain/models/product_base.dart';
import 'package:lichi_app/internal/hex_color.dart';
import 'package:lichi_app/router/router.dart';
import 'package:lichi_app/ui/bloc/basket/basket_bloc.dart';
import 'package:lichi_app/ui/bloc/basket/basket_state.dart';

@RoutePage()
class ProductPage extends StatelessWidget {
  final Product product;
  List<String> allColors = <String>[];
  final DataService _dataService = DataService();

  ProductPage({super.key, required this.product}) {
    allColors.add(product.current.value);
    product.other.forEach((element) {
      allColors.add(element.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                placeholder: (context, url) => Container(
                  child: SizedBox(),
                ),
                // width: MediaQuery.of(context).size.width,
                // height: 260,
                imageUrl: product.photos[0].big,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 65),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        count = 0;
                        context.read<BasketBloc>().products.forEach(
                          (element) {
                            count += element.count;
                          },
                        );
                        return ElevatedButton(
                            onPressed: () {
                              AutoRouter.of(context).push(BasketRoute());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize: Size(78, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset("assets/icons/basket_black.png"),
                                Text(
                                  count.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 21),
                                ),
                              ],
                            ));
                      },
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: ElevatedButton(
                          onPressed: () {
                            AutoRouter.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                              alignment: Alignment.center,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45),
                              )),
                          child: Image.asset('assets/icons/close_black.png')),
                    ),
                  ],
                ),
              )
            ],
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
              onPressed: () async {
                ProductBase productBase = ProductBase(
                    id: product.id,
                    name: product.name,
                    price: product.price,
                    description: product.description,
                    currentValueColor: product.current.value,
                    photo: product.photos[0].big,
                    count: 1);

                List<ProductBase> prB = context
                    .read<BasketBloc>()
                    .products
                    .where((element) => element.id == productBase.id)
                    .toList();
                if (prB.isNotEmpty) {
                  productBase.count = prB.first.count + 1;
                } else {
                  context.read<BasketBloc>().products.add(productBase);
                }
                await _dataService.cuProduct(productBase);
              },
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
