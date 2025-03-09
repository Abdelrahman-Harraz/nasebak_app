part of 'membership_bloc.dart';

sealed class MembershipState extends Equatable {
  const MembershipState();

  @override
  List<Object> get props => [];
}

final class MembershipInitialState extends MembershipState {}

class MembershipLoadingState extends MembershipState {
  const MembershipLoadingState();
}

class MembershipErrorState extends MembershipState {
  final String errorMessage;
  final bool isLocalizationKey;
  const MembershipErrorState({
    required this.errorMessage,
    required this.isLocalizationKey,
  });

  @override
  List<Object> get props => [errorMessage, isLocalizationKey];
}

class MembershipDataLoadedSuccessfullyState extends MembershipState {
  final List<MembershipUiModel> model;
  const MembershipDataLoadedSuccessfullyState({required this.model});
}
