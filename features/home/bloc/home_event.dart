part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialFetchEvent extends HomeEvent{}

class HomeStudentsAddButtonClickedEvent extends HomeEvent{}

class HomeSignOutButtonClickedEvent extends HomeEvent{}

