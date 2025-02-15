class SignUpSendApiModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String passwordConfirmation;

  const SignUpSendApiModel(
      {required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.passwordConfirmation});

  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "confirmPassword": passwordConfirmation,
    };
  }
}
