import 'package:digitalcontractsapp/app/router.gr.dart';
import 'package:dio/dio.dart';
import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/data_models/business.dart';
import 'package:digitalcontractsapp/data_models/rubro.dart';
import 'package:digitalcontractsapp/services/api.dart';
import 'package:digitalcontractsapp/services/app_model_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

const String _BusinessFuture = 'bussinessFuture';

class UserHomeViewModel extends FutureViewModel {
  final Api _api = locator<Api>();
  final AppModel _appModel = locator<AppModel>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<Rubro> _rubros = new List();
  List<Business> _contracts = new List();
  List<Business> _contractsFound = new List();
  String _selectedRubro = '';
  bool _errorFetchingRubros = false;
  bool _errorFetchingBusiness = false;
  bool _isSearching = false;

  // * Getters

  List<Rubro> get rubros => _rubros;
  List<Business> get contracts => _contracts;
  List<Business> get contractsFound => _contractsFound;

  bool get fetchingBusiness => busy(_BusinessFuture);

  bool get errorFetchingRubros => _errorFetchingRubros;
  bool get errorFetchingBusiness => _errorFetchingBusiness;
  bool get isSearching => _isSearching;

  VoidCallback get openDrawer => _appModel.openDrawer;

  // * Functions

  @override
  Future futureToRun() => _getContracts();

  Future<void> _getContracts() async {}

  Future<void> _getContract() async {
    setBusyForObject(_BusinessFuture, true);
    setBusyForObject(_BusinessFuture, false);
  }

  updateBusinessByRubro(int index) async {
    _selectedRubro = _rubros[index].id;
    _contracts.clear();
    _getContract();
    notifyListeners();
  }

  void searchBusiness(String business) async {
    if (business.isNotEmpty) {
      _isSearching = true;

      try {
        _contractsFound = [];
      } catch (e) {
        _contractsFound = [];
      }
    }
    notifyListeners();
  }

  void closeSearch(String business) async {
    _isSearching = false;
    notifyListeners();
  }

  void goToContractView() {
    _navigationService.navigateTo(Routes.contractPresentationViewRoute);
  }
}
