import 'package:go_router/go_router.dart';
import 'package:nasebak_app/features/app_navigation/screen/app_navigation_screen.dart';
import 'package:nasebak_app/features/phone_registration/screen/phone_registration_screen.dart';
import 'package:nasebak_app/only_debug/user_debug_model.dart';
import 'package:nasebak_app/utils/build_type/build_type.dart';

class AppRouter {
  static const initialRoute = phoneRegistrationScreen;
  static const phoneRegistrationScreen = "/phone-registration-screen";
  static const appNavigationScreen = "/app-navigation-screen";

  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialRoute,
    routes: <RouteBase>[
      GoRoute(
        path: appNavigationScreen,
        builder: (context, state) {
          final argument = state.extra as Map<String, dynamic>?;
          return AppNavigationScreen(
            index: argument?[AppNavigationScreen.appNavigationIndex],
            key: argument?[AppNavigationScreen.keyValue],
          );
        },
      ),
      GoRoute(
        path: phoneRegistrationScreen,
        builder: (context, state) {
          final argument = state.extra as Map<String, dynamic>? ?? {};
          final phoneCode =
              isDebugMode()
                  ? UserDebugModel.country
                  : argument[PhoneRegistrationScreen.argumentPhoneCode]
                          as String? ??
                      "+966";

          return PhoneRegistrationScreen(initialPhoneCode: phoneCode);
        },
      ),
    ],
  );
}
