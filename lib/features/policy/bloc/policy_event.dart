part of 'policy_bloc.dart';

sealed class PolicyEvent extends Equatable {
  const PolicyEvent();

  @override
  List<Object> get props => [];
}

class GetPolicyDataEvent extends PolicyEvent {}
