import '../../models/users_model.dart';

class UsresResponse {
  List<UserModel>? users;

  UsresResponse.fromJson(List<dynamic> json) {
    users = json.map((product) => UserModel.fromJson(product)).toList();
  }
}
