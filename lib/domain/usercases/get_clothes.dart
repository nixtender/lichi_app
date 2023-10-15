import 'package:lichi_app/domain/models/product.dart';

import '../../internal/dependencies/repository_module.dart';
import '../repository/api_repository.dart';

class GetClothes {
  final ApiRepository _api = RepositoryModule.apiRepository();

  GetClothes();

  Future<dynamic> getClothes(
          int shop, int lang, String category, int limit) async =>
      await _api.getClothes(
          shop: shop, lang: lang, category: category, limit: limit);
}
