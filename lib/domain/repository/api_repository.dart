abstract class ApiRepository {
  Future<dynamic> getClothes(
      {required int shop,
      required int lang,
      required String category,
      required int limit});
}
