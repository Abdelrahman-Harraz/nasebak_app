part of 'promote_profile_bloc.dart';

sealed class PromoteProfileState extends Equatable {
  const PromoteProfileState();

  @override
  List<Object> get props => [];
}

final class PromoteProfileInitialState extends PromoteProfileState {}

class PromoteProfileLoadingState extends PromoteProfileState {
  const PromoteProfileLoadingState();
}

class PromoteProfileErrorState extends PromoteProfileState {
  final String errorMessage;
  final bool isLocalizationKey;
  const PromoteProfileErrorState({
    required this.errorMessage,
    required this.isLocalizationKey,
  });

  @override
  List<Object> get props => [errorMessage, isLocalizationKey];
}

class PromoteProfileDataLoadedSuccessfullyState extends PromoteProfileState {
  final List<PromoteProfileUiModel> promoteProfileUiModel;
  const PromoteProfileDataLoadedSuccessfullyState({
    required this.promoteProfileUiModel,
  });
}
