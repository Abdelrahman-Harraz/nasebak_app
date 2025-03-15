import 'package:go_router/go_router.dart';
import 'package:nasebak_app/features/app_navigation/screen/app_navigation_screen.dart';
import 'package:nasebak_app/features/membership/screen/membership_screen.dart';
import 'package:nasebak_app/features/notifications/screen/notification_screen.dart';
import 'package:nasebak_app/features/otp/screen/otp_screen.dart';
import 'package:nasebak_app/features/phone_registration/screen/phone_registration_screen.dart';
import 'package:nasebak_app/features/policy/screen/policy_screen.dart';
import 'package:nasebak_app/features/promote_profile/screen/promote_profile_screen.dart';
import 'package:nasebak_app/features/search/screen/search_screen.dart';
import 'package:nasebak_app/features/update_user_info/screen/update_user_info_screen.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';
import 'package:nasebak_app/features/user_info/screen/user_info_screen.dart';
import 'package:nasebak_app/features/vip_membership/screen/vip_membership_screen.dart';
import 'package:nasebak_app/only_debug/user_debug_model.dart';
import 'package:nasebak_app/utils/build_type/build_type.dart';

class AppRouter {
  static const initialRoute = phoneRegistrationScreen;
  static const phoneRegistrationScreen = "/phone-registration-screen";
  static const appNavigationScreen = "/app-navigation-screen";
  static const otpScreen = "/otp-screen";
  static const policyScreen = "/policy-screen";
  static const updateUserInfoScreen = "/update-user-info-screen";
  static const membershipScreen = "/membership-screen";
  static const vipMembershipScreen = "/vip-membership-screen";
  static const promoteProfileScreen = "/promote-profile-screen";
  static const notificationsScreen = "/notifications-screen";
  static const userInfoScreen = "/user-info-screen";
  static const searchScreen = "/search-screen";

  static const userInfoModelKey = "user_info_model";
  static const isCurrentUserKey = "is_current_user";
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    //!Change later
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
                  : (argument[PhoneRegistrationScreen.argumentPhoneCode]
                          as String?) ??
                      "+966";

          return PhoneRegistrationScreen(initialPhoneCode: phoneCode);
        },
      ),

      GoRoute(path: otpScreen, builder: (context, state) => OtpScreen()),
      GoRoute(path: policyScreen, builder: (context, state) => PolicyScreen()),
      GoRoute(
        path: updateUserInfoScreen,
        builder: (context, state) => UpdateUserInfoScreen(),
      ),
      GoRoute(
        path: membershipScreen,
        builder: (context, state) => MembershipScreen(),
      ),
      GoRoute(
        path: vipMembershipScreen,
        builder: (context, state) => VipMembershipScreen(),
      ),
      GoRoute(
        path: promoteProfileScreen,
        builder: (context, state) => PromoteProfileScreen(),
      ),
      GoRoute(
        path: notificationsScreen,
        builder: (context, state) => NotificationScreen(),
      ),
      GoRoute(
        path: userInfoScreen,
        builder: (context, state) {
          final arguments = state.extra as Map<String, dynamic>?;
          if (arguments == null) {
            return UserInfoScreen(userInfo: UserInfoUiModel.dummyUserInfo);
          }
          final userInfo = arguments[userInfoModelKey] as UserInfoUiModel;
          return UserInfoScreen(userInfo: userInfo);
        },
      ),
      GoRoute(path: searchScreen, builder: (context, state) => SearchScreen()),
    ],
  );
}
