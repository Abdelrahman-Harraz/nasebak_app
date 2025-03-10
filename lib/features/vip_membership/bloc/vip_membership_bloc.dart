import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nasebak_app/features/vip_membership/bloc/vip_membership_repository.dart';
import 'package:nasebak_app/features/vip_membership/model/vip_membership_ui_model.dart';

part 'vip_membership_event.dart';
part 'vip_membership_state.dart';

class VipMembershipBloc extends Bloc<VipMembershipEvent, VipMembershipState> {
  final BaseVipMembershipRepository vipMembershipRepository;
  VipMembershipBloc({required this.vipMembershipRepository})
    : super(VipMembershipInitialState()) {
    on<GetVipMembershipDataEvent>(_getVipMembershipDataEvent);
  }

  FutureOr<void> _getVipMembershipDataEvent(
    GetVipMembershipDataEvent event,
    Emitter<VipMembershipState> emit,
  ) async {
    emit(VipMembershipLoadingState());
    emit(await vipMembershipRepository.vipMembershipData());
  }
}
