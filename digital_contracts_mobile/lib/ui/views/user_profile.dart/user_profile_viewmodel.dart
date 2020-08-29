import 'package:digitalcontractsapp/app/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/data_models/user.dart';
import 'package:digitalcontractsapp/services/app_model_service.dart';
import 'package:digitalcontractsapp/ui/views/user_profile.dart/user_update_information_popup/user_update_information_popup_view.dart';
import 'package:digitalcontractsapp/ui/widgets/alerts/alerts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserProfileViewModel extends BaseViewModel {
  final AppModel _appModel = locator<AppModel>();
  final NavigationService _navigationService = locator<NavigationService>();

  BuildContext _context;

  // * Getters

  User get user => _appModel.user;
  VoidCallback get openDrawer => _appModel.openDrawer;

  // * Functions

  void initialize(BuildContext context) {
    _context = context;
  }

  void showUpdateUserPopup() {
    showDialog(
      context: _context,
      builder: (_) => UserUpdateInformationPopupView(),
    ).then((value) async {
      notifyListeners();
    });
  }

  void logout() {
    Alert(context: _context, title: 'Alerta', label: '¿Está seguro que desea salir?').logout(() async {
      _navigationService.pushNamedAndRemoveUntil(Routes.loginViewRoute);
    });
  }
}
