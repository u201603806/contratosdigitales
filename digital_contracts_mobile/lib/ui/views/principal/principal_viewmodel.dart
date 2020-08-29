import 'package:digitalcontractsapp/app/router.gr.dart';
import 'package:digitalcontractsapp/services/storage_service.dart';
import 'package:digitalcontractsapp/ui/views/notifications/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/data_models/enums/user_type.dart';
import 'package:digitalcontractsapp/data_models/user.dart';
import 'package:digitalcontractsapp/res/pallete_color.dart';
import 'package:digitalcontractsapp/services/api.dart';
import 'package:digitalcontractsapp/services/app_model_service.dart';
import 'package:digitalcontractsapp/ui/views/client_home/client_home_view.dart';
import 'package:digitalcontractsapp/ui/views/user_home/user_home_view.dart';
import 'package:digitalcontractsapp/ui/views/user_profile.dart/user_profile_view.dart';
import 'package:digitalcontractsapp/ui/widgets/alerts/alerts.dart';
import 'package:digitalcontractsapp/utils/token.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PrincipalViewModel extends BaseViewModel {
  int _currentIndex = 0;
  final Api _api = locator<Api>();
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();
  final AppModel _appModel = locator<AppModel>();
  final Token _tokenService = new Token();

  BuildContext _context;
  List<Widget> _tabWidgets;

  // * Getters

  int get currentIndex => _currentIndex;
  List<Widget> get tabWidgets => _tabWidgets;
  User get user => _appModel.user;

  // * Functions

  void initialize(BuildContext context, int index, VoidCallback openDrawer) async {
    setBusy(true);
    _currentIndex = index;
    _context = context;
    _appModel.setOpenDrawer(openDrawer);
    await fillInitialData();
    setBusy(false);
  }

  Future<void> fillInitialData() async {
    
    var userTypeString = await _storageService.getString('userType'); 
    UserType userType = UserTypeHelper.getUserFromString(userTypeString);
    _appModel.updateUser(User(
      documentNumber: '12345678',
      email: 'test@contracts.com',
      googleID: '1234566',
      image: '',
      phone: '9888331231',
      name: 'User Test',
    ));
    switch (userType) {
      case UserType.User:
        _tabWidgets = [
          UserHomeView(),
          NotificationsView(),
          NotificationsView(),
          UserProfileView(),
        ];
        break;
      case UserType.Business:
        _tabWidgets = [
          ClientHomeView(),
          NotificationsView(),
          NotificationsView(),
          UserProfileView(),
        ];
        break;
      default:
        _tabWidgets = [
          UserHomeView(),
          NotificationsView(),
          NotificationsView(),
          UserProfileView(),
        ];
    }
  }

  // * Functions
  void updateCurrentIndex(int index, {bool closeHiddenDrawer = false}) {
    _currentIndex = index;
    if (closeHiddenDrawer) _appModel.openDrawer();
    notifyListeners();
  }

  Color getColorBottomButton({@required int index}) => currentIndex == index ? PalleteColor.activeButtonBottomBar : Colors.grey;

  void logout() {
    Alert(context: _context, title: 'Alerta', label: '¿Está seguro que desea salir?').logout(() async {
      _navigationService.pushNamedAndRemoveUntil(Routes.loginViewRoute);
    });
  }
}
