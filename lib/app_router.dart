import 'package:nasebak_app/features/app_navigation/screen/app_navigation_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const initialRoute = "/";
  static const appNavigationScreen = "/app-navigation-screen";

  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
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
    ],
  );
}
