import 'package:dio/dio.dart';
import 'package:lichi_app/domain/models/product.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/")
  Future<dynamic> getClothes(@Query("shop") int shop, @Query("lang") int lang,
      @Query("category") String category, @Query("limit") int limit);
}
