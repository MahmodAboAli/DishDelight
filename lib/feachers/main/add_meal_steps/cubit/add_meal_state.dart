part of 'add_meal_cubit.dart';

@immutable
sealed class AddMealState {}

final class AddMealInitial extends AddMealState {}

class ChangeRecipeState extends AddMealState {}

class ChangesomethingState extends AddMealState {}

class GetMealForAddState extends AddMealState {}

class ChangeCategoryState extends AddMealState {}

class RemoveState extends AddMealState {}

class ChangeValueState extends AddMealState {}

class IncrementState extends AddMealState {}

class Step2done extends AddMealState {}

class AddIngredientState extends AddMealState {}

class AddTheMealState extends AddMealState {}