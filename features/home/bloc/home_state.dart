part of 'home_bloc.dart';

@immutable
sealed class HomeState {}
abstract class HomeActionState extends HomeState{}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{}

class HomeLoadedSuccessState extends HomeState{}

class HomeErrorState extends HomeState{}

class HomeNavigateToLoginPageActionState extends HomeActionState{}

class HomeEditNotesSuccessState extends HomeState{}

class HomeDeleteNotesSuccessState extends HomeState{}

class HomeNavigateToAddStuentDetailsActionState extends HomeActionState{}

