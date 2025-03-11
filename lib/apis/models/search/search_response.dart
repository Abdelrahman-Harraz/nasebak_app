import 'package:equatable/equatable.dart';
import 'package:nasebak_app/apis/models/user_info/get_user_info/get_user_info_api_model.dart';

class SearchResponse extends Equatable {
  final List<GetUserInfoApiModel> userInfo;

  const SearchResponse({required this.userInfo});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      userInfo:
          json['userInfo'] != null
              ? (json['userInfo'] as List<dynamic>)
                  .map((e) => GetUserInfoApiModel.fromJson(e))
                  .toList()
              : [],
    );
  }

  @override
  List<Object?> get props => [userInfo];
}
