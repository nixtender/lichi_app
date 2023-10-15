import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/domain/usercases/get_clothes.dart';

import 'catalog_event.dart';
import 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final apiService = GetClothes();
  CatalogBloc(super.initialState) {
    on<CatalogLoadingEvent>((event, emit) async {
      var responce = await apiService.call(2, 1, 'dresses', 1);
      print(responce);
    });
  }
}
