import 'package:dio/dio.dart';

import '../../const/my_string.dart';
import '../../data/clients/api_client.dart';

class ApiModule {
  static ApiClient? _apiClient;
  static ApiClient api() =>
      _apiClient ??
      ApiClient(
        Dio(),
        baseUrl: baseUrl,
      );
}
