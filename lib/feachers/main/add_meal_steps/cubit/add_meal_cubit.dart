import 'package:DISH_DELIGhTS/core/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../meal_detial_page/models/meal_detial_model.dart';

part 'add_meal_state.dart';

class AddMealCubit extends Cubit<AddMealState> {
  AddMealCubit() : super(AddMealInitial());
  static AddMealCubit get(context) => BlocProvider.of(context);
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController recipeController = TextEditingController();

  List<String> ingredient = [''];
  List<double> valuesofingredient = [1];
  List<String> prepration = [''];

  AddTheMeal({required MealDetial meal}) async {
    String doc_id = '';
    await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial meal, options) => meal.toFirestore(),
        )
        .add(meal)
        .then((value) {
      doc_id = value.id;
      return meal.id = value.id;
    });
    await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) => meal.toFirestore(),
        )
        .doc(doc_id)
        .update(meal.toFirestore());
    str = '';
    // ! I have to refresh the meals
    // getData();
    emit(AddTheMealState());
  }

  addprepration(int index, String value) {
    prepration[index] = value;
    emit(AddIngredientState());
  }

  dicrementListofprepration() {
    if (prepration.length > 1) {
      prepration.removeLast();
    }
    emit(RemoveState());
  }

  incrementListofprepration() {
    prepration.add('');
    emit(IncrementState());
  }

  addIngredientofprepration(int index, String value) {
    ingredient[index] = value;
    emit(AddIngredientState());
  }

  addIngredient(int index, String value) {
    ingredient[index] = value;
    emit(AddIngredientState());
  }

  String timeMeal = '';
  String description = '';

  Step2don({required String descrip, required String time}) {
    description = descrip;
    timeMeal = time;
    emit(Step2done());
  }

  changevalue(int index, double value) {
    valuesofingredient[index] = value;
    emit(ChangeValueState());
  }

  changevalueofprapration(int index, double value) {
    valuesofingredient[index] = value;
    emit(ChangeValueState());
  }

  incrementList() {
    ingredient.add('');
    valuesofingredient.add(1);
    emit(IncrementState());
  }

  dicrementList() {
    if (ingredient.length > 1) {
      ingredient.removeLast();
      valuesofingredient.removeLast();
    }
    emit(RemoveState());
  }

  String title = '';
  changeRecipe(String Name) {
    title = Name;
    emit(ChangeRecipeState());
  }

  String catigoryName = 'Main';
  changeCatigoryName(String ctg) {
    catigoryName = ctg;
    emit(ChangesomethingState());
  }

  changeCategory(String Category) {
    catigoryName = Category;
    emit(ChangeCategoryState());
  }

  bool foundMeal = false;
  findMeal({required String tit}) async {
    var fMeal = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial Mealforadd, options) =>
              Mealforadd.toFirestore(),
        )
        .where('title', isEqualTo: tit)
        .get();
    (fMeal.docs.isEmpty) ? foundMeal = false : foundMeal = true;

    emit(GetMealForAddState());
  }
}
