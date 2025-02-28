import 'package:equatable/equatable.dart';
import 'package:nasebak_app/apis/models/user_info/get_user_info/get_user_info_api_model.dart';

class HomeApiModel extends Equatable {
  final GetUserInfoApiModel userInfo;
  final GetUserInfoApiModel otherUserInfo;

  const HomeApiModel({required this.userInfo, required this.otherUserInfo});

  factory HomeApiModel.fromJson(Map<String, dynamic> json) {
    return HomeApiModel(
      userInfo: GetUserInfoApiModel.fromJson(json["userInfo"]),
      otherUserInfo: GetUserInfoApiModel.fromJson(json["otherUserInfo"]),
    );
  }
  @override
  List<Object?> get props => [userInfo, otherUserInfo];
}
