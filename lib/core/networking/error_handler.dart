import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pagination_app/core/networking/faileur.dart';

class ErrorHandler implements Exception {
  late Faileur faileur;
  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      faileur = _getFaileurError(error);
    } else {
      faileur = DataSource.DEFAULT.getFaileur();
    }
  }
}

_getFaileurError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFaileur();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFaileur();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFaileur();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusMessage != null &&
          error.response?.statusCode != null) {
        log("error message : ${error.response?.statusMessage}");
        log("error code : ${error.response?.statusCode}");
        return error.response?.statusMessage == 'Payment Required'
            ? Faileur(402, 'invalid card , try again')
            : Faileur(error.response?.statusCode ?? 0,
                error.response?.data['message'] ?? '');
      } else {
        return DataSource.DEFAULT.getFaileur();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCELED.getFaileur();
    case DioExceptionType.unknown:
      return DataSource.DEFAULT.getFaileur();
    case DioExceptionType.badCertificate:
      return DataSource.BAD_REQUEST.getFaileur();
    case DioExceptionType.connectionError:
      return DataSource.NO_CONNECTION_INTERNET.getFaileur();
  }
}

enum DataSource {
  NO_CONTENT,
  BAD_REQUEST,
  UNAUTHORIZED,
  FORBIDDEN,
  INTERNAL_SERVER_ERROR,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHED_ERROR,
  CANCELED,
  NO_CONNECTION_INTERNET,
  DEFAULT
}

class ResponseMessage {
  static const String NO_CONTENT = "success with no content";
  static const String BAD_REQUEST = "request rejected ,  try again later";
  static const String UNAUTHORIZED = "user unauthorized ,  try again later";
  static const String FORBIDDEN = "request rejected , try again later";
  static const String INTERNAL_SERVER_ERROR =
      "internal server error , try again later";
  static const String RECIEVE_TIMEOUT = "error timeout , try again later";
  static const String SEND_TIMEOUT = "error timeout , try again later";
  static const String CACHED_ERROR = "cached error , try again later";
  static const String CANCELED = "request canceled ,  try again later";
  static const String NO_CONNECTION_INTERNET =
      "chek your connection internet and try again";
  static const String DEFAULT = "some thing went wrong , try again later";
}

class ResponseCode {
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int UNAUTHORIZED = 405;
  static const int FORBIDDEN = 406;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int RECIEVE_TIMEOUT = -1;
  static const int SEND_TIMEOUT = -2;
  static const int CACHED_ERROR = -3;
  static const int CANCELED = -4;
  static const int NO_CONNECTION_INTERNET = -5;
  static const int DEFAULT = -6;
}

extension DataSourceExtention on DataSource {
  Faileur getFaileur() {
    switch (this) {
      case DataSource.NO_CONTENT:
        return Faileur(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Faileur(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.UNAUTHORIZED:
        return Faileur(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);
      case DataSource.FORBIDDEN:
        return Faileur(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Faileur(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.RECIEVE_TIMEOUT:
        return Faileur(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Faileur(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHED_ERROR:
        return Faileur(ResponseCode.CACHED_ERROR, ResponseMessage.CACHED_ERROR);
      case DataSource.CANCELED:
        return Faileur(ResponseCode.CANCELED, ResponseMessage.CANCELED);
      case DataSource.NO_CONNECTION_INTERNET:
        return Faileur(ResponseCode.NO_CONNECTION_INTERNET,
            ResponseMessage.NO_CONNECTION_INTERNET);
      case DataSource.DEFAULT:
        return Faileur(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}
