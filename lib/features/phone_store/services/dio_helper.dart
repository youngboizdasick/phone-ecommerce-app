import 'package:dio/dio.dart';

class ApiHelper {
  static void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        print('Connection Timeout Exception');
        break;
      case DioExceptionType.sendTimeout:
        print('Send Timeout Exception');
        break;
      case DioExceptionType.receiveTimeout:
        print('Receive Timeout Exception');
        break;
      case DioExceptionType.badResponse:
        print('Bad Response: ${e.response?.data}');
        break;
      case DioExceptionType.cancel:
        print('Request Cancelled');
        break;
      case DioExceptionType.badCertificate:
        print('Bad Certificate');
        break;
      case DioExceptionType.connectionError:
        print('Connection Error');
        break;
      case DioExceptionType.unknown:
        print('Unknown Exception: ${e.message}');
        break;
      default:
        print('Orther Exception: ${e.message}');
        break;
    }
  }

  static void logUnexpectedError(dynamic e) {
    print('Unexpected error: $e');
  }

  static void handleNon200Response(Response response) {
    switch (response.statusCode) {
      case 400:
        print('Bad Request: ${response.data}');
        break;
      case 401:
        print('Unauthorized: ${response.data}');
        break;
      case 403:
        print('Forbidden: ${response.data}');
        break;
      case 404:
        print('Not Found: ${response.data}');
        break;
      default:
        print('Unhandled Error: ${response.statusCode}, ${response.data}');
        break;
    }
  }
}
