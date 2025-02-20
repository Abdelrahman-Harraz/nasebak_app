import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nasebak_app/features/policy/bloc/policy_repository.dart';
import 'package:nasebak_app/features/policy/model/policy_ui_model.dart';

part 'policy_event.dart';
part 'policy_state.dart';

class PolicyBloc extends Bloc<PolicyEvent, PolicyState> {
  final BasePolicyRepository policyRepository;
  PolicyBloc({required this.policyRepository}) : super(PolicyInitialState()) {
    on<GetPolicyDataEvent>(_getPolicyDataEvent);
  }

  FutureOr<void> _getPolicyDataEvent(
    GetPolicyDataEvent event,
    Emitter<PolicyState> emit,
  ) async {
    emit(LoadingState());
    emit(await policyRepository.policyData());
  }
}
