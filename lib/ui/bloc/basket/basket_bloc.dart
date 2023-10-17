import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/data/services/data_service.dart';
import 'package:lichi_app/domain/models/product_base.dart';
import 'package:lichi_app/ui/bloc/basket/basket_event.dart';
import 'package:lichi_app/ui/bloc/basket/basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  List<ProductBase> products = <ProductBase>[];
  final DataService _dataService = DataService();

  BasketBloc(super.initialState) {
    on<BasketLoadingEvent>(
      (event, emit) async {
        emit(BasketLoadingState());
        products = await _dataService.getProducts();
        if (products.isNotEmpty) {
          emit(BasketLoadedState());
        } else {
          emit(BasketEmptyState());
        }
      },
    );
  }
}
