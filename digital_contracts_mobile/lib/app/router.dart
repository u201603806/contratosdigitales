import 'package:auto_route/auto_route_annotations.dart';
import 'package:digitalcontractsapp/ui/views/contracts_register/contracts_register_view.dart';
import 'package:digitalcontractsapp/ui/views/enroll/enroll_view.dart';
import 'package:digitalcontractsapp/ui/views/login/login_view.dart';
import 'package:digitalcontractsapp/ui/views/onboarding/onboarding_view.dart';
import 'package:digitalcontractsapp/ui/views/principal/principal_view.dart';
import 'package:digitalcontractsapp/ui/views/user_home/user_home_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  LoginView loginViewRoute;
  UserHomeView homeViewRoute;
  PrincipalView principalViewRoute;
  EnrollView enrollViewRoute;
  OnBoardingView onBoardingViewRoute;
  ContractsRegisterView contractsRegisterViewRoute;
}
