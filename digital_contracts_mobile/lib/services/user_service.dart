import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:digitalcontractsapp/data_models/user.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class UserService with ReactiveServiceMixin {
  RxValue<User> _user = RxValue<User>();
  User get counter => _user.value;

  UserService() {
    listenToReactiveValues([_user]);
  }

  void updateUser(User user) {
    _user.value = user;
  }
}