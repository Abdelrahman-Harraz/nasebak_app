import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/my_app.dart';
import 'package:nasebak_app/preferences/preferences_manager.dart';
import 'package:nasebak_app/utils/bloc_observer/app_bloc_observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  /// to fix Orientation problem
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    /// setup GetIt Instances ...
    GetIt.I.registerLazySingleton<PreferencesManager>(
      () => PreferencesManager(),
    );

    GetIt.I.registerLazySingleton<DioApiManager>(
      () => DioApiManager(preferenceManager: GetIt.I<PreferencesManager>()),
    );

    Bloc.observer = AppBlocObserver();
    runApp(const MyApp());
  });
}
