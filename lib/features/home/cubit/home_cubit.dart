import 'package:bloc/bloc.dart';
import 'package:pagination_app/features/home/cubit/home_state.dart';
import 'package:pagination_app/features/home/data/repository/users_repo.dart';
import 'package:pagination_app/features/home/models/users_model.dart';

class HomeCubit extends Cubit<HomeState> {
  final UsersRepository _usersRepository;
  HomeCubit(this._usersRepository) : super(HomeInitial());
  List<UserModel> users = [];
  String error = "";
  bool stopRequests = false;
  getUsers() async {
    var response = await _usersRepository.getUsers(users.length, 10);
    response.fold((err) {
      error = err.message;
      stopRequests = false;
      emit(ErrorLoadProducts(error));
    }, (res) {
      users.addAll(res.users ?? []);
      stopRequests = false;
      emit(UsersLoaded(users));
    });
  }
}
