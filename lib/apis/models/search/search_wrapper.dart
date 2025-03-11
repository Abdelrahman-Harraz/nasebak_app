import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';
import 'package:nasebak_app/apis/models/search/search_response.dart';

class SearchWrapper extends BaseWrapper {
  final SearchResponse data;
  SearchWrapper(this.data, super.isSuccess, super.details, super.message);

  SearchWrapper.fromJson(super.json)
    : data = SearchResponse.fromJson(json),
      super.fromJson();
}
