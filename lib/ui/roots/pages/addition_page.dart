import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/domain/models/product_base.dart';
import 'package:lichi_app/router/router.dart';
import 'package:lichi_app/ui/bloc/basket/basket_bloc.dart';
import 'package:lichi_app/ui/bloc/basket/basket_event.dart';
import 'package:lichi_app/ui/bloc/basket/basket_state.dart';

@RoutePage()
class AdditionPage extends StatelessWidget {
  final ProductBase productBase;

  AdditionPage({required this.productBase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: StatefulBuilder(
        builder: (context, setState) => Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Text(
              "Добавлено в корзину",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 100,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.network(
                    productBase.photo,
                    fit: BoxFit.cover,
                  ),
                )),
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Text(
                productBase.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Размер XS",
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () => AutoRouter.of(context).replace(BasketRoute()),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(500, 71),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Text(
                  "Перейти в корзину",
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<BasketBloc>().add(BasketLoadingEvent());
                AutoRouter.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Text(
                  "Закрыть",
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
