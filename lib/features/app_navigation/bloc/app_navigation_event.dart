part of 'app_navigation_bloc.dart';

sealed class AppNavigationEvent extends Equatable {
  const AppNavigationEvent();

  @override
  List<Object> get props => [];
}

class SelectBottomNavigationItemEvent extends AppNavigationEvent {
  final int index;

  const SelectBottomNavigationItemEvent({required this.index});
}
