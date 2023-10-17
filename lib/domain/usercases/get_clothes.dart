import 'package:dio/dio.dart';

import '../../internal/dependencies/repository_module.dart';
import '../repository/api_repository.dart';

class GetClothes {
  final ApiRepository _api = RepositoryModule.apiRepository();

  GetClothes();

  Future<dynamic> getClothes(
      int shop, int lang, String category, int limit, int page) async {
    try {
      return await _api.getClothes(
          shop: shop, lang: lang, category: category, limit: limit, page: page);
    } on DioError catch (e) {
      print(e);
      throw NoNetworkException();
    }
  }

  Future<dynamic> getSelectCloth(int shop, int lang, int id) async {
    try {
      return await _api.getSelectCloth(shop, lang, id);
    } catch (e) {
      throw DataBaseException();
    }
  }
}

class NoNetworkException implements Exception {}

class DataBaseException implements Exception {}
