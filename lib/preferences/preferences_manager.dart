import 'package:nasebak_app/preferences/preferences_keys.dart';
import 'package:nasebak_app/utils/preferences/preferences_utils.dart';

class PreferencesManager {
  Future<bool> clearData() async {
    final String? locale = await getLocale();
    await PreferencesUtils.clearData();
    if (locale != null) await setLocale(locale);
    await setShowOnboarding();

    return true;
  }

  Future<bool> setLocale(String data) async {
    return await PreferencesUtils.setString(PreferencesKeys.lang.name, data);
  }

  Future<String?> getLocale() async {
    return await PreferencesUtils.getString(PreferencesKeys.lang.name);
  }

  Future<void> setLoggedIn() async {
    await PreferencesUtils.setBool(PreferencesKeys.isLoggedIn.name, true);
  }

  Future<bool> isLoggedIn() async {
    return await PreferencesUtils.getBool(PreferencesKeys.isLoggedIn.name);
  }

  Future<String?> getUserName() async {
    return await PreferencesUtils.getString(PreferencesKeys.userName.name);
  }

  Future<void> setUserName(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.userName.name, data);
  }

  Future<void> setToken(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.token.name, data);
  }

  Future<String?> getToken() async {
    return await PreferencesUtils.getString(PreferencesKeys.token.name);
  }

  Future<bool> isShowOnboarding() async {
    return await PreferencesUtils.getBool(PreferencesKeys.showOnboarding.name);
  }

  Future<void> setShowOnboarding() async {
    await PreferencesUtils.setBool(PreferencesKeys.showOnboarding.name, true);
  }

  Future<int?> getUserId() async {
    return await PreferencesUtils.getInt(PreferencesKeys.userId.name);
  }

  Future<void> setUserId(int userId) async {
    await PreferencesUtils.setInt(PreferencesKeys.userId.name, userId);
  }

  Future<void> setEmail(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.email.name, data);
  }

  Future<String?> getEmail() async {
    return await PreferencesUtils.getString(PreferencesKeys.email.name);
  }

  Future<void> setProfileImage(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.profileImage.name, data);
  }

  Future<String?> getProfileImage() async {
    return await PreferencesUtils.getString(PreferencesKeys.profileImage.name);
  }

  Future<bool> setIsAllowNotifications(bool data) async {
    return await PreferencesUtils.setBool(
      PreferencesKeys.isAllowNotifications.name,
      data,
    );
  }

  Future<bool> getIsAllowNotifications() async {
    return await PreferencesUtils.getBool(
      PreferencesKeys.isAllowNotifications.name,
    );
  }

  Future<void> setScreenStatusWhileRecording(bool data) async {
    await PreferencesUtils.setBool(
      PreferencesKeys.screenStatusWhileRecording.name,
      data,
    );
  }

  Future<bool> getScreenStatusWhileRecording() async {
    return await PreferencesUtils.getBool(
      PreferencesKeys.screenStatusWhileRecording.name,
    );
  }

  Future<void> setDownloadImagesStatus(bool data) async {
    await PreferencesUtils.setBool(
      PreferencesKeys.downloadImagesStatus.name,
      data,
    );
  }

  Future<bool> getDownloadImagesStatus() async {
    return await PreferencesUtils.getBool(
      PreferencesKeys.downloadImagesStatus.name,
    );
  }

  Future<void> setIsGuest() async {
    await PreferencesUtils.setBool(PreferencesKeys.isGuest.name, true);
  }

  Future<bool> isGuest() async {
    return await PreferencesUtils.getBool(PreferencesKeys.isGuest.name);
  }
}
