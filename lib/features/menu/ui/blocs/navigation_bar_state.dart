part of 'navigation_bar_bloc.dart';

sealed class NavigationBarState extends Equatable {
  final int index;
  const NavigationBarState(this.index);
}

final class NavigationBarStateChanged extends NavigationBarState {
  const NavigationBarStateChanged(super.index);

  @override
  List<Object?> get props => [index];
}
