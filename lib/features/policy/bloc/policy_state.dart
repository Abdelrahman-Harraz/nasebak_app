part of 'policy_bloc.dart';

sealed class PolicyState extends Equatable {
  const PolicyState();

  @override
  List<Object> get props => [];
}

final class PolicyInitialState extends PolicyState {}

class LoadingState extends PolicyState {}

class ErrorState extends PolicyState {
  final String errorMessage;
  final bool isLocalizationKey;

  const ErrorState({
    required this.errorMessage,
    required this.isLocalizationKey,
  });
}

class LoadedPolicyDataSuccessfullyState extends PolicyState {
  final List<PolicyUiModel> policyUiModel;

  const LoadedPolicyDataSuccessfullyState({required this.policyUiModel});
}
