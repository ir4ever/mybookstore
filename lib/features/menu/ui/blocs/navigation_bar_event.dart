part of 'navigation_bar_bloc.dart';

sealed class NavigationBarEvent extends Equatable {
  const NavigationBarEvent();
}

final class NavigationBarChangedEvent extends NavigationBarEvent {
  final int index;
  const NavigationBarChangedEvent(this.index);

  @override
  List<Object?> get props => [index];
}
