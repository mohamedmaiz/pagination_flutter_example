import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pagination_app/core/networking/error_handler.dart';
import 'package:pagination_app/core/networking/faileur.dart';
import 'package:pagination_app/core/networking/network_info.dart';
import 'package:pagination_app/features/home/data/responses/users_response.dart';

class UsersRepository {
  UsersRepository(this._dio, this._networkInfo);
  final NetworkInfo _networkInfo;
  final Dio _dio;
  Future<Either<Faileur, UsresResponse>> getUsers(int skip, int limits) async {
    if (await _networkInfo.isConnected) {
      try {
        var response = await _dio
            .get("users", queryParameters: {"skip": skip, "limit": limits});
        UsresResponse products = UsresResponse.fromJson(response.data);
        return right(products);
      } catch (e) {
        return left(ErrorHandler.handle(e).faileur);
      }
    } else {
      return left(DataSource.NO_CONNECTION_INTERNET.getFaileur());
    }
  }
}
