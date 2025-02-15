part of 'app_navigation_bloc.dart';

sealed class AppNavigationState extends Equatable {
  const AppNavigationState();

  @override
  List<Object> get props => [];
}

final class AppNavigationInitialState extends AppNavigationState {}

class SelectedBottomNavigationItemState extends AppNavigationState {
  final int index;

  const SelectedBottomNavigationItemState({required this.index});

  @override
  List<Object> get props => [index];
}
