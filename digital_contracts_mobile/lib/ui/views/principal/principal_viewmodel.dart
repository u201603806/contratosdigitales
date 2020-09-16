import 'package:digitalcontractsapp/app/router.gr.dart';
import 'package:digitalcontractsapp/data_models/user_login.dart';
import 'package:digitalcontractsapp/services/storage_service.dart';
import 'package:digitalcontractsapp/ui/views/notifications/notifications_view.dart';
import 'package:digitalcontractsapp/ui/views/user_appointment/user_appointment_view.dart';
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
  UserLogin _userLogin;

  BuildContext _context;
  List<Widget> _tabWidgets;

  // * Getters

  int get currentIndex => _currentIndex;
  List<Widget> get tabWidgets => _tabWidgets;
  User get user => _appModel.user;

  // * Functions

  void initialize(BuildContext context, VoidCallback openDrawer, UserLogin userLogin) async {
    setBusy(true);
    _context = context;
    _userLogin = userLogin;
    _appModel.setOpenDrawer(openDrawer);
    await fillInitialData();
    setBusy(false);
  }

  Future<void> fillInitialData() async {
    _appModel.updateUser(User(
      idUser: '${_userLogin.idUsuario}',
      codUser: _userLogin.codUsuario,
      documentNumber: '12345678',
      email: _userLogin.codUsuario,
      googleID: '1234566',
      image: '',
      phone: '9888331231',
      name: '${_userLogin.nombre} ${_userLogin.apellido}',
    ));
    switch (_userLogin.perfil) {
      case 'Colaborador':
        _tabWidgets = [
          UserHomeView(),
          UserAppointmentView(),
          NotificationsView(),
          UserProfileView(),
        ];
        break;
      case 'Administrador':
        _tabWidgets = [
          ClientHomeView(),
          UserAppointmentView(),
          NotificationsView(),
          UserProfileView(),
        ];
        break;
      default:
        _tabWidgets = [
          UserHomeView(),
          UserAppointmentView(),
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
