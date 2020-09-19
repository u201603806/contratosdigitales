import 'package:auto_route/auto_route_annotations.dart';
import 'package:digitalcontractsapp/ui/views/colaborators_contract/colaborators_contract_view.dart';
import 'package:digitalcontractsapp/ui/views/consulting_contracts/consulting_contracts_view.dart';
import 'package:digitalcontractsapp/ui/views/contract_presentation/contract_presentation_view.dart';
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
  ContractPresentationView contractPresentationViewRoute;
  ConsultingContractsView consultingContractsViewRoute;
  ColaboratorsContractView colaboratorsContractViewRoute;
}
