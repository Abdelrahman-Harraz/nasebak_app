part of 'vip_membership_bloc.dart';

sealed class VipMembershipEvent extends Equatable {
  const VipMembershipEvent();

  @override
  List<Object> get props => [];
}

class GetVipMembershipDataEvent extends VipMembershipEvent {
  const GetVipMembershipDataEvent();
}
