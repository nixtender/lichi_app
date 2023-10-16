import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/ui/bloc/basket/basket_event.dart';
import 'package:lichi_app/ui/bloc/basket/basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc(super.initialState) {}
}
