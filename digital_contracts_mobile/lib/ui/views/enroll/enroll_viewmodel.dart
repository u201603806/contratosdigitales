import 'package:digitalcontractsapp/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/app/router.gr.dart';
import 'package:digitalcontractsapp/data_models/enums/user_type.dart';
import 'package:digitalcontractsapp/services/api.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EnrollViewModel extends BaseViewModel {
  final Api _api = locator<Api>();
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusName = FocusNode();
  final FocusNode _focusPhone = FocusNode();
  final FocusNode _focusDocumentNumber = FocusNode();
  final FocusNode _focusPassword = FocusNode();
  UserType _userTypeSelected = UserType.User;

  String _email = "";
  String _name = "";
  String _phone = "";
  String _password = "";

  // * Getters
  get formKey => _formKey;
  FocusNode get focusName => _focusName;
  FocusNode get focusPhone => _focusPhone;
  FocusNode get focusDocumentNumber => _focusDocumentNumber;
  FocusNode get focusPassword => _focusPassword;
  UserType get userTypeSelected => _userTypeSelected;

  // * Functions

  void setUserType(UserType userType) {
    _userTypeSelected = userType;
    notifyListeners();
  }

  void signInGoogle() {
    _navigationService.pushNamedAndRemoveUntil(Routes.principalViewRoute);
  }

  void registerAccount(BuildContext _) async {
    FocusScope.of(_).unfocus();
    //if (_formKey.currentState.validate()) {
      _storageService.saveString('userType', _userTypeSelected.toString());
      await _navigationService.pushNamedAndRemoveUntil(Routes.principalViewRoute);
    //}
  }

  void updateEmail(String value) {
    _email = value;
  }

  void updateName(String value) {
    _name = value;
  }

  void updatePhone(String value) {
    _phone = value;
  }

  void updatePassword(String value) {
    _password = value;
  }
}
