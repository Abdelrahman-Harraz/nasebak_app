part of 'promote_profile_bloc.dart';

sealed class PromoteProfileEvent extends Equatable {
  const PromoteProfileEvent();

  @override
  List<Object> get props => [];
}

class GetPromoteProfileDateEvent extends PromoteProfileEvent {}
