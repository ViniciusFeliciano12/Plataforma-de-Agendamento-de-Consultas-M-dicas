import 'package:get_it/get_it.dart';
import 'package:hospital_gamificacao/services/hospital_api.dart';
import 'package:hospital_gamificacao/services/interfaces/ihospital_api.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerLazySingleton<IHospitalApi>(() => HospitalAPI());
  // getIt.registerLazySingleton<IDatabase>(() => MarvelDB());
  // getIt.registerLazySingleton<IImageFolder>(() => ImageFolder());
  // getIt.registerLazySingleton<IThemeService>(() => ThemeService());
  // getIt.registerLazySingleton<IRadioService>(() => MarvelRadio());
}
