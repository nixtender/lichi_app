import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/const/my_string.dart';
import 'package:lichi_app/ui/bloc/basket/basket_bloc.dart';
import 'package:lichi_app/ui/bloc/basket/basket_event.dart';
import 'package:lichi_app/ui/bloc/basket/basket_state.dart';
import 'package:lichi_app/ui/widgets/purchase_item.dart';

@RoutePage()
class BasketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var BB = context.read<BasketBloc>();
    context.read<BasketBloc>().add(BasketLoadingEvent());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Корзина",
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
      ),
      body: BlocBuilder<BasketBloc, BasketState>(
        builder: (context, state) {
          if (state is BasketLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.black,
              ),
            );
          }
          if (state is BasketEmptyState) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                EMPTY_BASKET,
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 13,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (state is BasketLoadedState) {
            return Column(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                flex: 5,
                child: ListView.builder(
                  itemBuilder: (context2, index) {
                    return PurchaseItem(productBase: BB.products[index]);
                  },
                  itemCount: BB.products.length,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black,
                  child: SizedBox(),
                ),
              )
            ]);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
