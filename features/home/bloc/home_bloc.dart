import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialFetchEvent>(homeInitialFetchEvent);
    on<HomeStudentsAddButtonClickedEvent>(homeStudentsAddButtonClickedEvent);
    on<HomePopOverEditNotesDetailsButtonClickedEvent>(homePopOverEditNotesDetailsButtonClickedEvent);
    on<HomePopOverDeleteNotesButtonClickedEvent>(homePopOverDeleteNotesButtonClickedEvent);
    on<HomeSignOutButtonClickedEvent>(homeSignOutButtonClickedEvent);
  }

  FutureOr<void> homeInitialFetchEvent(HomeInitialFetchEvent event, Emitter<HomeState> emit) async{
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 2));
    emit(HomeLoadedSuccessState());
  }

  FutureOr<void> homeStudentsAddButtonClickedEvent(HomeStudentsAddButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToAddStuentDetailsActionState());
  }

  FutureOr<void> homePopOverEditNotesDetailsButtonClickedEvent(HomePopOverEditNotesDetailsButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeEditNotesSuccessState());
  }

  FutureOr<void> homePopOverDeleteNotesButtonClickedEvent(HomePopOverDeleteNotesButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeDeleteNotesSuccessState());
  }

  FutureOr<void> homeSignOutButtonClickedEvent(HomeSignOutButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToLoginPageActionState());
  }

}
