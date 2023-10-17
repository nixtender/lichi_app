import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/data/services/data_service.dart';
import 'package:lichi_app/domain/models/product_base.dart';
import 'package:lichi_app/ui/bloc/basket/basket_bloc.dart';
import 'package:lichi_app/ui/bloc/basket/basket_event.dart';

class PurchaseItem extends StatefulWidget {
  ProductBase productBase;

  PurchaseItem({required this.productBase});

  @override
  State<PurchaseItem> createState() => _PurchaseItemState();
}

class _PurchaseItemState extends State<PurchaseItem> {
  final DataService dataService = DataService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      height: 180,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => Container(
              child: SizedBox(),
            ),
            width: 135,
            height: 180,
            imageUrl: widget.productBase.photo,
            imageBuilder: (_, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 170,
                child: Text(
                  widget.productBase.name,
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Text(
                "Размер XS",
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "${widget.productBase.price} руб.",
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: TextButton(
                        onPressed: () async {
                          widget.productBase.count--;
                          await dataService
                              .cuProduct(widget.productBase)
                              .then((value) {
                            context
                                .read<BasketBloc>()
                                .add(BasketLoadingEvent());
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFFF0F0F0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                        child: Image.asset('assets/icons/remove.png')),
                  ),
                  Text(
                    "  ${widget.productBase.count} ед.  ",
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: TextButton(
                        onPressed: () async {
                          widget.productBase.count++;
                          await dataService
                              .cuProduct(widget.productBase)
                              .then((value) {
                            context
                                .read<BasketBloc>()
                                .add(BasketLoadingEvent());
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFFF0F0F0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                        child: Image.asset('assets/icons/add.png')),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
