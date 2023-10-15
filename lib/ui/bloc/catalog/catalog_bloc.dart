import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/domain/usercases/get_clothes.dart';

import '../../../domain/models/product.dart';
import 'catalog_event.dart';
import 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final apiService = GetClothes();
  CatalogBloc(super.initialState) {
    on<CatalogLoadingEvent>((event, emit) async {
      var responcePrivate = await apiService.getClothes(2, 1, 'dresses', 1);
      var aProduct = responcePrivate['api_data']['aProduct'][0];
      var htmlDescription = aProduct['descriptions']['html'];
      aProduct['description'] = htmlDescription;
      var current = aProduct['colors']['current'];
      aProduct['current'] = current;
      var other = aProduct['colors']['other'];
      aProduct['other'] = other;
      final valuePoduct = Product.fromJson(aProduct);
      emit(CatalogLoadedState(product: valuePoduct));
    });
  }
}
