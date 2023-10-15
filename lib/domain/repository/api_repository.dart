import 'package:lichi_app/domain/models/product.dart';

abstract class ApiRepository {
  Future<dynamic> getClothes(
      {required int shop,
      required int lang,
      required String category,
      required int limit});
}
