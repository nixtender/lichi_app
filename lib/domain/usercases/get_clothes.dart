import '../../internal/dependencies/repository_module.dart';
import '../repository/api_repository.dart';

class GetClothes {
  final ApiRepository _api = RepositoryModule.apiRepository();

  GetClothes();

  Future<dynamic> getClothes(
          int shop, int lang, String category, int limit, int page) async =>
      await _api.getClothes(
          shop: shop, lang: lang, category: category, limit: limit, page: page);

  Future<dynamic> getSelectCloth(int shop, int lang, int id) async =>
      await _api.getSelectCloth(shop, lang, id);
}
