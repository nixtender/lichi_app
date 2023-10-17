import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/const/my_string.dart';
import 'package:lichi_app/data/services/data_service.dart';
import 'package:lichi_app/internal/transform_product.dart';
import 'package:lichi_app/router/router.dart';
import 'package:lichi_app/ui/bloc/basket/basket_bloc.dart';
import 'package:lichi_app/ui/bloc/basket/basket_event.dart';
import 'package:lichi_app/ui/bloc/basket/basket_state.dart';
import 'package:lichi_app/ui/bloc/catalog/catalog_bloc.dart';
import 'package:lichi_app/ui/bloc/catalog/catalog_event.dart';
import 'package:lichi_app/ui/bloc/catalog/catalog_state.dart';
import 'package:lichi_app/ui/roots/pages/product_page.dart';
import 'package:lichi_app/ui/widgets/product_item.dart';

@RoutePage()
class CatalogPage extends StatelessWidget {
  final lvc = ScrollController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    context.read<BasketBloc>().add(BasketLoadingEvent());
    context.read<CatalogBloc>().add(CatalogLoadingEvent(cloth: DRESSES));
    lvc.addListener(() {
      bool finishScroll = context.read<CatalogBloc>().finishScroll;
      var max = lvc.position.maxScrollExtent;
      var current = lvc.offset;
      var percent = (current / max * 100);
      if (percent > 90 && !finishScroll) {
        if (!isLoading) {
          isLoading = true;
          Future.delayed(const Duration(seconds: 1)).then((value) async {
            context.read<CatalogBloc>().add(CatalogScrollEvent());
            isLoading = false;
          });
        }
      }
    });
    int count = 0;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          controller: lvc,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 78,
                  ),
                  Text(
                    "Каталог товаров",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
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
                              backgroundColor: Colors.black,
                              fixedSize: Size(78, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                count.toString(),
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 21),
                              ),
                              Image.asset("assets/icons/basket.png"),
                            ],
                          ));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                SLOGAN,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {},
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width / 2, 78)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ))),
                      icon: Image.asset("assets/icons/moon_black.png"),
                      label: Text(
                        "   Темная тема",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: TextButton.icon(
                          onPressed: () {},
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(
                                  MediaQuery.of(context).size.width / 2, 78)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ))),
                          icon: Image.asset("assets/icons/sun_black.png"),
                          label: Text(
                            "   Светлая тема",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          )))
                  // ElevatedButton(onPressed: onPressed, child: child),
                ],
              ),
            ),
            BlocBuilder<CatalogBloc, CatalogState>(
              builder: (context, state) {
                String category = context.read<CatalogBloc>().category;
                if (state is CatalogEmptyState) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          TransformProduct.selectWid(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 145,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$category  ",
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                              Image.asset("assets/icons/expand_more_black.png"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          EMPTY_CLOTH,
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }
                if (state is CatalogLoadingState) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          TransformProduct.selectWid(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 145,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$category  ",
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                              Image.asset("assets/icons/expand_more_black.png"),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  );
                }
                if (state is CatalogLoadedState) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          TransformProduct.selectWid(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 145,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$category  ",
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                              Image.asset("assets/icons/expand_more_black.png"),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: ((_, index) {
                            return GestureDetector(
                              onTap: () {
                                AutoRouter.of(context).push(ProductRoute(
                                    product: state.products[index]));
                              },
                              child:
                                  ProductItem(product: state.products[index]),
                            );
                          }),
                          itemCount: state.products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.45,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 5,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (state is CatalogErrorState) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          TransformProduct.selectWid(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 145,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$category  ",
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                              Image.asset("assets/icons/expand_more_black.png"),
                            ],
                          ),
                        ),
                      ),
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
                          context.read<CatalogBloc>().add(CatalogLoadingEvent(
                              cloth: context.read<CatalogBloc>().cloth));
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
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
