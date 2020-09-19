import 'package:dio/dio.dart';
import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/data_models/business.dart';
import 'package:digitalcontractsapp/services/api.dart';
import 'package:digitalcontractsapp/services/app_model_service.dart';
import 'package:stacked/stacked.dart';
import 'package:digitalcontractsapp/app/router.gr.dart';
import 'package:stacked_services/stacked_services.dart';

class ClientHomeViewModel extends FutureViewModel<List<Business>> {
  final Api _api = locator<Api>();
  final AppModel _appModel = locator<AppModel>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<Business> _businesses = new List();
  List<Business> _businessesFound = new List();
  bool _isSearching = false;

  // * Getters

  List<Business> get businesses => _businesses;
  List<Business> get businessesFound => _businessesFound;

  bool get isSearching => _isSearching;
  VoidCallback get openDrawer => _appModel.openDrawer;

  // * Functions

  @override
  Future<List<Business>> futureToRun() => _getContract();

  Future<List<Business>> _getContract() async {}

  void searchBusiness(String business) async {
    if (business.isNotEmpty) {
      _isSearching = true;

      try {
        _businessesFound = [];
      } catch (e) {
        _businessesFound = [];
      }
    }
    notifyListeners();
  }

  void closeSearch(String business) async {
    _isSearching = false;
    notifyListeners();
  }

  void goToRegisterBusinessForm() {
    _navigationService.navigateTo(Routes.contractsRegisterViewRoute);
  }

  void goToConsultingContracts() {
    _navigationService.navigateTo(Routes.consultingContractsViewRoute);
  }
}
