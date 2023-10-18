import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lichi_app/const/my_string.dart';
import 'package:lichi_app/data/services/data_service.dart';
import 'package:lichi_app/domain/models/product.dart';
import 'package:lichi_app/domain/models/product_base.dart';
import 'package:lichi_app/internal/hex_color.dart';
import 'package:lichi_app/internal/space_price.dart';
import 'package:lichi_app/router/router.dart';
import 'package:lichi_app/ui/bloc/basket/basket_bloc.dart';
import 'package:lichi_app/ui/bloc/basket/basket_state.dart';
import 'package:lichi_app/ui/bloc/product/product_bloc.dart';
import 'package:lichi_app/ui/bloc/product/product_event.dart';
import 'package:lichi_app/ui/bloc/product/product_state.dart';
import 'package:lichi_app/ui/widgets/page_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class ProductPage extends StatelessWidget {
  Product? product;
  int? id;

  final DataService _dataService = DataService();
  PageController pageController = PageController();

  ProductPage([this.product, this.id]);

  @override
  Widget build(BuildContext context) {
    int count = 0;
    if (product == null) {
      context.read<ProductBloc>().add(ProductLoadingEvent(id));
    } else {
      context.read<ProductBloc>().add(ProductLoadingEvent());
    }
    return Scaffold(body: BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return Container(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          );
        }
        if (state is ProductLoadedState) {
          product ??= state.product;
          List<String> allColors = <String>[];
          allColors.add(product!.current.value);
          product!.other.forEach((element) {
            allColors.add(element.value);
          });
          return ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 524,
                    child: PageView.builder(
                      controller: pageController,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (pageContext, pageIndex) {
                        return CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            child: SizedBox(),
                          ),
                          // width: MediaQuery.of(context).size.width,
                          // height: 260,
                          imageUrl: product!.photos[pageIndex].big,
                        );
                      },
                      itemCount: product!.photos.length,
                    ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                        "assets/icons/basket_black.png"),
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
                              child:
                                  Image.asset('assets/icons/close_black.png')),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 524,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0x77FFFFFF)),
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: product!.photos.length,
                          effect: SlideEffect(
                              radius: 6,
                              dotHeight: 6,
                              dotWidth: 6,
                              spacing: 4,
                              dotColor: Colors.white,
                              activeDotColor: Colors.black),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 27,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  product!.name,
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
                product!.current.name,
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
                "${SpacePrice.getSpacePrice(product!.price)} руб.",
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
                        id: product!.id,
                        name: product!.name,
                        price: product!.price,
                        description: product!.description,
                        currentValueColor: product!.current.value,
                        photo: product!.photos[0].big,
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
                    await _dataService.cuProduct(productBase).then((value) =>
                        AutoRouter.of(context)
                            .push(AdditionRoute(productBase: productBase)));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(500, 71),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
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
                  data: product!.description,
                  style: {
                    "p": Style(lineHeight: LineHeight(1.5)),
                    "ul": Style(
                        lineHeight: LineHeight(1.5),
                        padding: HtmlPaddings(left: HtmlPadding(15)))
                  },
                ),
              ),
            ],
          );
        }
        if (state is ProductErrorState) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  ERROR_CLOTH,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 13,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 150,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProductBloc>().add(ProductLoadingEvent(id));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(10, 71),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    "Повторить",
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    ));
  }
}
