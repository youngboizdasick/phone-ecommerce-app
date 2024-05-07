import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/services/api_urls.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../models/product_intro.dart';

class ApiServices {
  final Dio api = Dio();
  String? accessToken;
  final _storage = const FlutterSecureStorage();

  ApiServices() {
    api.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!options.path.contains('http')) {
            options.path = '${ApiUrls().BASE_URL}${options.path}';
          }
          options.headers['Authorization'] = 'Bearer $accessToken';
          options.headers['appCode'] = 'RETAIL';
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if ((error.response?.statusCode ==
                  401 /* &&
              error.response?.data['message'] == "Invalid JWT"*/
              )) {
            if (await _storage.containsKey(key: 'refreshToken')) {
              // will throw error below
              await refreshToken();
              return handler.resolve(await _retry(error.requestOptions));
            }
          }
          return handler.next(error);
        },
      ),
    );

    api.interceptors.add(CurlLoggerDioInterceptor());

    api.interceptors.add(PrettyDioLogger());
  }

  Future<void> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    final response = await api.post(
      ApiUrls().API_REFRESH_TOKEN,
      data: {'refreshToken': refreshToken},
    );

    if (response.statusCode == 200) {
      // successfully got the new access token
      accessToken = response.data;
    } else {
      // log out user.
      accessToken = null;
      _storage.deleteAll();
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<void> storeTokens(Map<String, dynamic> data) async {
    // Lưu trữ access token
    await _storage.write(
        key: 'accessToken', value: data['data']['accessToken']);

    // Lưu trữ refresh token
    await _storage.write(
      key: 'refreshToken',
      value: data['data']['refreshToken'],
    );
  }

  Future<String?> getAccessToken() async {
    print(await _storage.read(key: 'accessToken'));
    return await _storage.read(key: 'accessToken');
  }

  Future<String?> getRefreshToken() async {
    print(await _storage.read(key: 'refreshToken'));
    return await _storage.read(key: 'refreshToken');
  }

  Future<bool> loginUser(String username, String password) async {
    try {
      final response = await api.post(
        ApiUrls().API_AUTH,
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        storeTokens(response.data);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> logout() async{
    await _storage.deleteAll();
    return true;
  }

  Future<ProductIntroModel?> fetchProductDetail(String uuid) async {
    try {
      final response = await api.get(ApiUrls().API_DETAIL_PRODUCT + uuid);
      if (response.statusCode == 200) {
        return ProductIntroModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
