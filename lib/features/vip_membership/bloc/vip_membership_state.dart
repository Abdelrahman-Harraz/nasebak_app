part of 'vip_membership_bloc.dart';

sealed class VipMembershipState extends Equatable {
  const VipMembershipState();

  @override
  List<Object> get props => [];
}

final class VipMembershipInitialState extends VipMembershipState {}

class VipMembershipLoadingState extends VipMembershipState {
  const VipMembershipLoadingState();
}

class VipMembershipErrorState extends VipMembershipState {
  final String errorMessage;
  final bool isLocalizationKey;
  const VipMembershipErrorState({
    required this.errorMessage,
    required this.isLocalizationKey,
  });

  @override
  List<Object> get props => [errorMessage, isLocalizationKey];
}

class VipMembershipDataLoadedSuccessfullyState extends VipMembershipState {
  final List<VipMembershipUiModel> vipMembershipUiModel;
  const VipMembershipDataLoadedSuccessfullyState({
    required this.vipMembershipUiModel,
  });
}
