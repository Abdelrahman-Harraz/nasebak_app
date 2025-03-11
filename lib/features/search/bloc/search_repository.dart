import 'package:nasebak_app/features/search/bloc/search_bloc.dart';
import 'package:nasebak_app/features/search/model/search_ui_model.dart';

abstract class BaseSearchRepository {
  Future<SearchState> searchApi();
}

class SearchRepository implements BaseSearchRepository {
  @override
  Future<SearchState> searchApi() async {
    return LoadedSearchResultDateSuccessfullyState(
      searchUiModel: SearchUiModel.dummySearch,
    );
  }
}
