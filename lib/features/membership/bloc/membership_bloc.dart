import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nasebak_app/features/membership/bloc/membership_repository.dart';
import 'package:nasebak_app/features/membership/model/membership_ui_model.dart';

part 'membership_event.dart';
part 'membership_state.dart';

class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  final BaseMembershipRepository membershipRepository;
  MembershipBloc({required this.membershipRepository})
    : super(MembershipInitialState()) {
    on<GetMembershipDataEvent>(_getMembershipDataEvent);
  }

  FutureOr<void> _getMembershipDataEvent(
    GetMembershipDataEvent event,
    Emitter<MembershipState> emit,
  ) async {
    emit(MembershipLoadingState());
    emit(await membershipRepository.membershipData());
  }
}
