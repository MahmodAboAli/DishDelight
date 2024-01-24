part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetMyMealState extends HomeState {}

class GetMyFeedbackState extends HomeState {}

class GetFAvoriteState extends HomeState {}

class LoadingState extends HomeState {}

class AddFavoriteState extends HomeState {}

class InitNeedState extends HomeState {}

class GetMealFeedbackState extends HomeState {}

class SelectState extends HomeState {}

class ChangeListofMealState extends HomeState {}

class HomeChangeIndicator extends HomeState {}
