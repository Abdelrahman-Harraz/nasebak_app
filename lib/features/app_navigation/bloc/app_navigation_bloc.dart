import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_navigation_event.dart';
part 'app_navigation_state.dart';

class AppNavigationBloc extends Bloc<AppNavigationEvent, AppNavigationState> {
  AppNavigationBloc() : super(AppNavigationInitialState()) {
    on<SelectBottomNavigationItemEvent>(_selectBottomNavigationItemEvent);
  }

  FutureOr<void> _selectBottomNavigationItemEvent(
      SelectBottomNavigationItemEvent event, Emitter<AppNavigationState> emit) {
    emit(SelectedBottomNavigationItemState(index: event.index));
  }
}
