class ApiKeys {
  /// KEYs
  static const authorization = "Authorization";
  static const accept = "Accept";
  static const applicationJson = "application/json";
  static const locale = "Accept-Language";
  static const contentType = "Content-Type";
  static const keyBearer = "Bearer";
  static const platform = "Platform";
  static const platformAndroid = "android";
  static const platformIos = "ios";
  static const appVersion = "App-Version";
  static const perPageKey = "per_page";
  static const pageNumberKey = "page";
  static const perPageValue = 10;
  static const categoryId = "category_id";
  static const dateKey = "date";
  static const searchKeyWordKey = "keyword";
  static const notificationActionKey = "action";

  /// URLs
  //! Add your own base url here
  static const baseUrl = "https://nasebak.com";

  static const apiKeyUrl = "/api";
  static const baseApiUrl = '/$apiKeyUrl';

  /// Authentication
  static const registerWithPhoneUrl = '$apiKeyUrl/';
  static const signUpUrl = '$apiKeyUrl/';
  static const registerWithOtpUrl = "$apiKeyUrl/";

  /// Policy
  static const policyUrl = "$apiKeyUrl/";

  /// user Info
  static const userInfoUrl = "$apiKeyUrl/";
  static const updateUserInfoUrl = "$apiKeyUrl/";
}
