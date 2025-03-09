part of 'membership_bloc.dart';

sealed class MembershipEvent extends Equatable {
  const MembershipEvent();

  @override
  List<Object> get props => [];
}

class GetMembershipDataEvent extends MembershipEvent {
  const GetMembershipDataEvent();
}
