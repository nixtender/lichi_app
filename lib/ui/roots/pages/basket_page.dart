import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BasketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Корзина",
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(children: [
        Expanded(child: SizedBox(), flex: 5),
        Expanded(
          child: Container(
            color: Colors.black,
            child: SizedBox(),
          ),
          flex: 1,
        )
      ]),
    );
  }
}
