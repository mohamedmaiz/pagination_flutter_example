import 'package:equatable/equatable.dart';

import '../models/users_model.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class UsersLoaded extends HomeState {
  final List<UserModel> users;
  UsersLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class ErrorLoadProducts extends HomeState {
  final String error;
  ErrorLoadProducts(this.error);
}
