part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitialState extends HomeState {}

class LoadingState extends HomeState {}

class ErrorState extends HomeState {
  final String errorMessage;
  final bool isLocalizationKey;

  const ErrorState({
    required this.errorMessage,
    required this.isLocalizationKey,
  });

  @override
  List<Object> get props => [identityHashCode(this)];
}

class LoadedHomeDataSuccessfullyState extends HomeState {
  final HomeUiModel myProfile;
  final HomeUiModel otherUsersProfiles;

  const LoadedHomeDataSuccessfullyState({
    required this.myProfile,
    required this.otherUsersProfiles,
  });
}
