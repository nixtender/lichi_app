import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/const/my_string.dart';
import 'package:lichi_app/domain/models/product.dart';
import 'package:lichi_app/domain/usercases/get_clothes.dart';
import 'package:lichi_app/internal/transform_product.dart';

import 'catalog_event.dart';
import 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  String category = "";
  String cloth = "";
  bool finishScroll = false;
  int currentPage = 1;
  final apiService = GetClothes();
  List<Product> valueProducts = <Product>[];
  CatalogBloc(super.initialState) {
    on<CatalogLoadingEvent>((event, emit) async {
      emit(CatalogLoadingState());
      currentPage = 1;
      cloth = event.cloth;
      var responcePrivate =
          await apiService.getClothes(2, 1, cloth, 4, currentPage);
      valueProducts = TransformProduct.transformListProduct(responcePrivate);
      switch (cloth) {
        case NOVELTY:
          category = NOVELTY_RU;
          break;
        case DRESSES:
          category = DRESSES_RU;
          break;
        case SKIRTS:
          category = SKIRTS_RU;
          break;
        case SHOES:
          category = SHOES_RU;
          break;
        default:
          category = DRESSES_RU;
      }
      if (valueProducts.isEmpty) {
        emit(CatalogEmptyState());
      } else {
        emit(CatalogLoadedState(products: valueProducts));
      }
    });
    on<CatalogScrollEvent>(
      (event, emit) async {
        currentPage++;
        try {
          var responcePrivate =
              await apiService.getClothes(2, 1, cloth, 4, currentPage);
          valueProducts
              .addAll(TransformProduct.transformListProduct(responcePrivate));
          emit(CatalogLoadedState(products: valueProducts));
        } catch (e) {
          finishScroll = true;
        }
      },
    );
  }
}
