abstract class ApiRepository {
  Future<dynamic> getClothes(
      {required int shop,
      required int lang,
      required String category,
      required int limit});

  Future<dynamic> getSelectCloth(int shop, int lang, int id);
}
