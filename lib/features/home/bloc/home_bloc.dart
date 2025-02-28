import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nasebak_app/features/home/bloc/home_repository.dart';
import 'package:nasebak_app/features/home/model/home_ui_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BaseHomeRepository homeRepository;
  HomeBloc({required this.homeRepository}) : super(HomeInitialState()) {
    on<GetHomeData>(_getHomeData);
  }

  FutureOr<void> _getHomeData(
    GetHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(LoadingState());
    emit(await homeRepository.homeData());
  }
}
