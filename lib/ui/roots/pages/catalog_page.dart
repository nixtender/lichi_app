import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:lichi_app/const/my_string.dart';
import 'package:lichi_app/ui/bloc/catalog/catalog_bloc.dart';
import 'package:lichi_app/ui/bloc/catalog/catalog_event.dart';
import 'package:lichi_app/ui/bloc/catalog/catalog_state.dart';
import 'package:lichi_app/ui/widgets/product_item.dart';

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
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
                  Container(
                    width: 78,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 21),
                        ),
                        Image.asset("assets/icons/basket.png"),
                      ],
                    ),
                  )
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
                  // ElevatedButton(onPressed: () {}, child: ),
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
            GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 145,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Платья  ",
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
            BlocProvider(
                create: (context) => CatalogBloc(CatalogEmptyState()),
                child: Builder(builder: ((context) {
                  context.read<CatalogBloc>().add(CatalogLoadingEvent());
                  return BlocBuilder<CatalogBloc, CatalogState>(
                    builder: (context, state) {
                      if (state is CatalogEmptyState) {
                        return Text("Empty");
                      }
                      if (state is CatalogLoadedState) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: ((_, index) {
                              return ProductItem(
                                  product: state.products[index]);
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
                        );
                      }
                      return const SizedBox();
                    },
                  );
                }))),
          ],
        ),
      ),
    );
  }
}