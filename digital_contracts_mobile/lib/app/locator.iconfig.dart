// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:digitalcontractsapp/services/api.dart';
import 'package:digitalcontractsapp/services/app_model_service.dart';
import 'package:digitalcontractsapp/services/third_parties_service_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:digitalcontractsapp/services/media_services.dart';
import 'package:digitalcontractsapp/services/storage_service.dart';
import 'package:digitalcontractsapp/services/user_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<Api>(() => Api());
  g.registerLazySingleton<AppModel>(() => AppModel());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<MediaService>(() => MediaService());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<StorageService>(() => StorageService());
  g.registerLazySingleton<UserService>(() => UserService());
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}
