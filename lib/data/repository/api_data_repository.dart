import 'package:lichi_app/data/clients/api_client.dart';
import 'package:lichi_app/domain/repository/api_repository.dart';

class ApiDataRepository extends ApiRepository {
  final ApiClient _apiClient;
  ApiDataRepository(this._apiClient);

  @override
  Future<dynamic> getClothes(
          {required int shop,
          required int lang,
          required String category,
          required int limit}) async =>
      await _apiClient.getClothes(shop, lang, category, limit);
}
