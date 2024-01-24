part of 'meal_detial_cubit.dart';

@immutable
abstract class MealDetialState {}

class MealDetialInitial extends MealDetialState {}
class changeState extends MealDetialState{}
class ChangePageState extends MealDetialState {}
class AddFavoriteState extends MealDetialState {}
class ChangeCategoryState extends MealDetialState {}
class ChangeNeedsAmountState extends MealDetialState {}
class AddNeedState extends MealDetialState{}