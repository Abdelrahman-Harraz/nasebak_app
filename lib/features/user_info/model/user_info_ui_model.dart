import 'package:nasebak_app/apis/models/user_info/get_user_info/get_user_info_api_model.dart';

class UserInfoUiModel {
  final int id;
  String? firstName;
  final String gender;
  final String marriageType;
  final String? userNotes;
  final String? userDescription;

  UserInfoUiModel({
    required this.gender,
    required this.marriageType,
    required this.id,
    this.userNotes,
    this.userDescription,
    this.firstName,
  });

  factory UserInfoUiModel.fromApi(GetUserInfoApiModel e) {
    return UserInfoUiModel(
      id: e.id,
      firstName: e.firstName,
      gender: e.gender,
      marriageType: e.marriageType,
      userNotes: e.userNotes,
      userDescription: e.userDescription,
    );
  }
}
