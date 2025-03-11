import 'package:nasebak_app/apis/models/search/search_response.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';

class SearchUiModel {
  final List<UserInfoUiModel> userInfo;

  const SearchUiModel({required this.userInfo});

  factory SearchUiModel.fromApiModel(SearchResponse e) => SearchUiModel(
    userInfo: e.userInfo.map((e) => UserInfoUiModel.fromApi(e)).toList(),
  );

  bool get isEmpty => userInfo.isEmpty;

  // Dummy data for testing
  static SearchUiModel dummySearch = SearchUiModel(
    userInfo: List.generate(5, (index) => UserInfoUiModel.dummyUserInfo),
  );
}
