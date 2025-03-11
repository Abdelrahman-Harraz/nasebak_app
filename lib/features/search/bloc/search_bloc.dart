import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nasebak_app/features/search/bloc/search_repository.dart';
import 'package:nasebak_app/features/search/model/search_ui_model.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final BaseSearchRepository searchRepository;
  SearchBloc({required this.searchRepository}) : super(SearchInitialState()) {
    on<GetSearchResultEvent>(_getSearchResultEvent);
    on<ChangeInSearchFieldEvent>(_changeInSearchFieldEvent);
  }

  FutureOr<void> _getSearchResultEvent(
    GetSearchResultEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoadingState());
    emit(await searchRepository.searchApi());
  }

  FutureOr<void> _changeInSearchFieldEvent(
    ChangeInSearchFieldEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(ChangeInSearchFieldState());
  }
}
