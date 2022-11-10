import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

import '../../../common/common.dart';
import '../../../common/enum/box_types.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const CurrentIndexState(PaisaPage.home)) {
    on<HomeEvent>((event, emit) {});
    on<CurrentIndexEvent>(_currentIndex);
  }

  late final settings = Hive.box(BoxType.settings.stringValue);

  PaisaPage currentPage = PaisaPage.home;

  void _currentIndex(
    CurrentIndexEvent event,
    Emitter<HomeState> emit,
  ) {
    if (currentPage != event.currentPage) {
      currentPage = event.currentPage;
      emit(CurrentIndexState(event.currentPage));
    }
  }

  int getIndexFromPage(PaisaPage currentPage) {
    switch (currentPage) {
      case PaisaPage.home:
        return 0;
      case PaisaPage.accounts:
        return 1;
      case PaisaPage.category:
        return 2;
      case PaisaPage.budgetOverview:
        return 3;
      case PaisaPage.debts:
        return 4;
    }
  }

  PaisaPage getPageFromIndex(int index) {
    switch (index) {
      case 1:
        return PaisaPage.accounts;
      case 2:
        return PaisaPage.category;
      case 3:
        return PaisaPage.budgetOverview;
      case 4:
        return PaisaPage.debts;
      case 0:
      default:
        return PaisaPage.home;
    }
  }
}
