class PhoneRegistrationSendModel {
  final String phoneNumber;
  final String countryCode;
  const PhoneRegistrationSendModel({
    required this.phoneNumber,
    required this.countryCode,
  });

  Map<String, dynamic> toMap() {
    return {'mobile': "+$countryCode$phoneNumber"};
  }
}
