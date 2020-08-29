import 'dart:io';

import 'package:digitalcontractsapp/data_models/user_login.dart';
import 'package:digitalcontractsapp/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/app/router.gr.dart';
import 'package:digitalcontractsapp/data_models/enums/user_type.dart';
import 'package:digitalcontractsapp/services/api.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:version/version.dart';

class LoginViewModel extends BaseViewModel {
  final Api _api = locator<Api>();
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  BuildContext _context;

  Version _currentVersion;
  Version _latestVersion;

  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusPassword = FocusNode();
  UserType _userTypeSelected = UserType.User;

  String _username = "";
  String _password = "";

  // * Getters

  get formKey => _formKey;
  FocusNode get focusPassword => _focusPassword;
  UserType get userTypeSelected => _userTypeSelected;

  // * Functions

  void initialize(BuildContext context) async {
    _context = context;
    setBusy(true);
    await _initVersion();
    setBusy(false);
  }

  Future<void> _initVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _currentVersion = Version.parse(packageInfo.version);
  }

  void setUserType(UserType userType) {
    _userTypeSelected = userType;
    notifyListeners();
  }

  void loginValidate(BuildContext _) async {
    FocusScope.of(_).unfocus();
    //if (_formKey.currentState.validate()) {
    await _storageService.saveString('userType', _userTypeSelected.toString());
    var response;
    try {
      response = await _api.loginUser({
        'codUsuario': _username,
        'clave': _password,
      });
    } catch (e) {}
    if (response != null) {
      UserLogin userLogin = UserLogin.fromJson(response['parametros']['usuario']);
      await _navigationService.pushNamedAndRemoveUntil(Routes.principalViewRoute, arguments: PrincipalViewArguments(userLogin: userLogin, currentIndex: 0));
    }
    // }
  }

  void updateEmail(String value) {
    _username = value;
  }

  void updatePassword(String value) {
    _password = value;
  }

  void goToEnroll(BuildContext _) async {
    FocusScope.of(_).unfocus();
    await _navigationService.navigateTo(Routes.enrollViewRoute);
  }
}
