import 'package:flutter/foundation.dart';
import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/services/app_model_service.dart';
import 'package:stacked/stacked.dart';

class NotificationsViewModel extends BaseViewModel {
  final AppModel _appModel = locator<AppModel>();

  // * Getters

  VoidCallback get openDrawer => _appModel.openDrawer;
}
