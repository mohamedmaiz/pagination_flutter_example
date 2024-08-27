import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pagination_app/core/networking/dio_factory.dart';
import 'package:pagination_app/core/networking/network_info.dart';
import 'package:pagination_app/features/home/cubit/home_cubit.dart';
import 'package:pagination_app/features/home/data/repository/users_repo.dart';

GetIt getIt = GetIt.instance;

Future initialApp() async {
  // get dio clien instance
  Dio dio = DioFactory().getDio();
  // create connection checker instance
  InternetConnectionChecker connectionChecker =
      InternetConnectionChecker.createInstance();
  //register network info as a lazy singleton
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker));
  //register UsersRepository
  getIt.registerLazySingleton<UsersRepository>(
      () => UsersRepository(dio, getIt<NetworkInfo>()));
  //register HomeCubit
  getIt.registerLazySingleton<HomeCubit>(
      () => HomeCubit(getIt<UsersRepository>()));
}
