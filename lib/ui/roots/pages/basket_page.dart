import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/const/my_string.dart';
import 'package:lichi_app/internal/space_price.dart';
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => AutoRouter.of(context).pop()),
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
            int sum = 0;
            BB.products.forEach(
              (element) {
                sum += element.price * element.count;
              },
            );
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "К оплате",
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${SpacePrice.getSpacePrice(sum)} руб.",
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 30,
                              fontWeight: FontWeight.w400),
                        ),
                      ]),
                ),
              )
            ]);
          }
          if (state is BasketErrorState) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Text(
                    ERROR_CLOTH,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 13,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(50),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<BasketBloc>().add(BasketLoadingEvent());
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
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
