class UserInfoSendApiModel {
  final String firstName;

  const UserInfoSendApiModel({required this.firstName});

  Map<String, dynamic> toMap() {
    return {"first_name": firstName};
  }
}
