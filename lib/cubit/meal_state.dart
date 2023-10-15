part of 'meal_cubit.dart';

@immutable
abstract class MealState {}

class MealInitial extends MealState {}

class loadingState extends MealState {}

class loadingMealState extends MealState {}

class publishFeedbackState extends MealState {}

class AddMealState extends MealState {}

class AddIngredientState extends MealState {}

class ChangeState extends MealState {}

class GetDataState extends MealState {}

class SendMessageSuccess extends MealState {}

class ListenMessageSuccess extends MealState {}

class GetMessagesSuccess extends MealState {}

class Step2done extends MealState {}

class ChangeCategoryState extends MealState {}

class ChangeRecipeState extends MealState {}

class incrementState extends MealState {}

class removeState extends MealState {}

class ChangeValueState extends MealState {}

class ChangeListofMealState extends MealState {}

class ChangeCatigoryState extends MealState {}

class ChangesomethingState extends MealState {}

class AddFavoriteState extends MealState {}

class getFAvoriteState extends MealState {}

class RemoveFavoritState extends MealState {}

class OpenDrawerState extends MealState {}

class getFeedbackState extends MealState {}

class getMyFeedbackState extends MealState {}

class getMealFeedbackState extends MealState {}

class ChangePageState extends MealState {}

class InitNeedState extends MealState {}

class ChangeNeedsAmountState extends MealState {}

class getShoplistState extends MealState {}

class removeNeedsState extends MealState {}

class getMealState extends MealState {}

class getMyMealState extends MealState {}

class EditProfileState extends MealState {}

class AddRateState extends MealState{}

class getBestMealState extends MealState{}

class getMealForAddState extends MealState{}

class getMealforFeedbackState extends MealState{}
//!waseam

class HomeChangeIndicator extends MealState {}

class ChangeRicepState extends MealState {}

class changericepState extends MealState {}

class CategoryState extends MealState {}

class RecipesState extends MealState {}

class HomeActiveMain extends MealState {}

class HomeActiveAppetizers extends MealState {}

class HomeActiveSweetis extends MealState {}

class HomeActiveDrinks extends MealState {}

class HomeActiveCandies extends MealState {}

class HomeActiveVegiterian extends MealState {}

class HomeToCategoryState extends MealState {}

class RecipeColorState extends MealState {}

class FeedbackColorState extends MealState {}


// ! LogIn

class LoginInitial extends MealState {}

class SuccessMealState extends MealState {}

class SuccessGetStartState extends MealState {}

class GetProfileState extends MealState{}

class Changeobscurypass extends MealState {}

class Changeobscurycon extends MealState {}

class finduserstate extends MealState {}

class setDataprofileState extends MealState{}
