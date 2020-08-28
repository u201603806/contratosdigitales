import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:digitalcontractsapp/data_models/business.dart';
import 'package:digitalcontractsapp/data_models/user.dart';

@lazySingleton
class AppModel extends ChangeNotifier {
  User _user = new User();
  Business _business = new Business();
  int _currentIndex = 0;
  List<Business> _clientBusiness;
  VoidCallback _openDrawer;

  User get user => _user;

  Business get business => _business;

  int get currentIndex => _currentIndex;

  List<Business> get clientBusiness => _clientBusiness;

  VoidCallback get openDrawer => _openDrawer;

  void updateCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void selectBusiness(Business business) {
    _business = business;
  }

  void updateUser(User user) {
    _user = user;
  }

  void updateClientBusiness(List<Business> clientBusiness) {
    _clientBusiness = clientBusiness;
  }

  void setOpenDrawer(VoidCallback opendrawer) => _openDrawer = opendrawer;
}
