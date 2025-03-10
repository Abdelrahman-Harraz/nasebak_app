import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nasebak_app/features/promote_profile/bloc/promote_profile_repository.dart';
import 'package:nasebak_app/features/promote_profile/model/promote_profile_ui_model.dart';

part 'promote_profile_event.dart';
part 'promote_profile_state.dart';

class PromoteProfileBloc
    extends Bloc<PromoteProfileEvent, PromoteProfileState> {
  final BasePromoteProfileRepository promoteProfileRepository;
  PromoteProfileBloc({required this.promoteProfileRepository})
    : super(PromoteProfileInitialState()) {
    on<GetPromoteProfileDateEvent>(_getPromoteProfileDateEvent);
  }

  FutureOr<void> _getPromoteProfileDateEvent(
    GetPromoteProfileDateEvent event,
    Emitter<PromoteProfileState> emit,
  ) async {
    emit(PromoteProfileLoadingState());
    emit(await promoteProfileRepository.promoteProfileData());
  }
}
