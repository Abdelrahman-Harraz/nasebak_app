part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchErrorState extends SearchState {
  final String errorMessage;
  final bool isLocalizationKey;

  const SearchErrorState({
    required this.errorMessage,
    required this.isLocalizationKey,
  });
}

class LoadedSearchResultDateSuccessfullyState extends SearchState {
  final SearchUiModel searchUiModel;

  const LoadedSearchResultDateSuccessfullyState({required this.searchUiModel});
}

class ChangeInSearchFieldState extends SearchState {}
