import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/domain/usercases/get_clothes.dart';
import 'package:lichi_app/internal/transform_product.dart';
import 'package:lichi_app/ui/bloc/product/product_event.dart';
import 'package:lichi_app/ui/bloc/product/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final apiService = GetClothes();
  ProductBloc(super.initialState) {
    on<ProductLoadingEvent>(
      (event, emit) async {
        if (event.id != null) {
          emit(ProductLoadingState());
          try {
            await apiService.getSelectCloth(2, 1, event.id!).then((value) {
              var prod = TransformProduct.transformSingleProduct(value);
              emit(ProductLoadedState(prod));
            });
          } on NoNetworkException {
            emit(ProductErrorState());
          } catch (e) {
            emit(ProductErrorState());
          }
        } else {
          emit(ProductLoadedState());
        }
      },
    );
  }
}
