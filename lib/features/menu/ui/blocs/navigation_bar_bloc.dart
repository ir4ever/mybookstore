import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'navigation_bar_event.dart';
part 'navigation_bar_state.dart';

class NavigationBarBloc extends Bloc<NavigationBarEvent, NavigationBarState> {
  final PageController pageController = PageController();

  NavigationBarBloc() : super(const NavigationBarStateChanged(0)) {
    on<NavigationBarChangedEvent>((event, emit) {
      if (event.index == state.index) return;

      pageController.jumpToPage(event.index);
      emit(NavigationBarStateChanged(event.index));
    });
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
