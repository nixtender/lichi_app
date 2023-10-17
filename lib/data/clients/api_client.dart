import 'package:dio/dio.dart';
import 'package:lichi_app/const/my_string.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/")
  Future<dynamic> getClothes(
      @Query("shop") int shop,
      @Query("lang") int lang,
      @Query("category") String category,
      @Query("limit") int limit,
      @Query("page") int page);

  @GET("${detailUrl}/")
  Future<dynamic> getSelectCloth(
      @Query("shop") int shop, @Query("lang") int lang, @Query("id") int id);
}
