import 'package:nasebak_app/apis/models/user_info/get_user_info/get_user_info_api_model.dart';

class UserInfoUiModel {
  final int id;
  String? firstName;

  UserInfoUiModel({required this.id, this.firstName});

  factory UserInfoUiModel.fromApi(GetUserInfoApiModel e) {
    return UserInfoUiModel(id: e.id, firstName: e.firstName);
  }
}
