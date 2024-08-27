import 'package:dio/dio.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";

class DioFactory {
  Dio getDio() {
    final dio = Dio();
    final Map<String, dynamic> header = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
    };
    dio.options = BaseOptions(
        headers: header,
        baseUrl:
            "https://fake.newbapi.com/user/api/v1/", // Do not leave your base api here [Always keep it in .env file for security]
        receiveTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 20));

    return dio;
  }
}
