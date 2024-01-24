import 'package:DISH_DELIGhTS/core/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../meal_detial_page/models/meal_detial_model.dart';
import '../models/feedback_model.dart';
import '../models/needs_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  var db = FirebaseFirestore.instance;

  MealDetial currMealDetial = MealDetial();

  int page = 0;
  void homechangeindicator(inte) {
    page = inte;
    emit(HomeChangeIndicator());
  }

  int indexOfSection = 1;
  changeListofMeal(int x) {
    indexOfSection = x;
    x == 1
        ? currMeal = mainMeals
        : x == 2
            ? currMeal = aprrtieMeals
            : x == 3
                ? currMeal = sweetesMeals
                : x == 4
                    ? currMeal = drinksMeals
                    : x == 5
                        ? currMeal = candiesMeals
                        : currMeal = veginMeals;
    emit(ChangeListofMealState());
  }

  bool selectMain = true;
  bool selectAprrtie = false;
  bool selectSweet = false;
  bool selectDrink = false;
  bool selectCandie = false;
  bool selectVegin = false;
  void homeActive_Catagory(int n) {
    selectAprrtie = selectMain =
        selectCandie = selectDrink = selectSweet = selectVegin = false;
    switch (n) {
      case 1:
        {
          selectMain = true;
        }
        break;
      case 2:
        {
          selectAprrtie = true;
        }
        break;
      case 3:
        {
          selectSweet = true;
        }
        break;
      case 4:
        {
          selectDrink = true;
        }
        break;
      case 5:
        {
          selectCandie = true;
        }
        break;
      case 6:
        {
          selectVegin = true;
        }
        break;
    }
    emit(SelectState());
  }

  getMealDetial({required String id}) async {
    var meal = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .where("title", isEqualTo: id)
        .get();
    currMealDetial = meal.docs[0].data();
  }

  getMealFeedbacks({required String id}) async {
    var getFeedbacks = await db
        .collection("Feedback")
        .where('title', isEqualTo: id)
        .withConverter(
          fromFirestore: FeedbackModel.fromFirestore,
          toFirestore: (FeedbackModel feedbackModel, options) =>
              feedbackModel.toFirestore(),
        )
        .get();
    mealFeedbacks.clear();
    for (var Feeds in getFeedbacks.docs) {
      mealFeedbacks.add(Feeds.data());
    }
    emit(GetMealFeedbackState());
  }

  initneeds(MealDetial meal) {
    for (var x = 0; x < meal.ingredient!.length; x++) {
      valueOfNeeds.add(
          Needs_Meal(meal.valueOfIngredient![x], name: meal.ingredient![x]));
    }
    emit(InitNeedState());
  }

  bool userMeal = false;
  getuserMeal(String title) async {
    var x = await db
        .collection("users")
        .doc(userdata.id)
        .collection("favorite")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .where('title', isEqualTo: title)
        .get();
    x.docs.isEmpty ? userMeal = false : userMeal = true;
    emit(GetFAvoriteState());
  }

  bool addfavorIteMealProcces = false;

  addfavoriteMeal(MealDetial meal, {bool userMealfavorite = false}) async {
    addfavorIteMealProcces = true;
    emit(LoadingState());
    if (userMealfavorite == true) {
      meal.favorite = false;
      userMeal = false;
    } else {
      meal.favorite = true;
      userMeal = true;
    }
    // emit(ChangeCategoryState());
    var themeal = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .where("title", isEqualTo: meal.title)
        .get();
    MealDetial myMeal = themeal.docs[0].data();
    myMeal.favorite = meal.favorite;
    await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .doc(myMeal.id)
        .update(myMeal.toFirestore());
    Meals.clear();
    var getmeal = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .get();
    for (var doc in getmeal.docs) {
      Meals.add(doc.data());
    }
    print('done1');
    var fmeal = await db
        .collection("users")
        .doc(userdata.id)
        .collection("favorite")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealde, options) => mealde.toFirestore(),
        )
        .where('title', isEqualTo: meal.title)
        .get();
    if (fmeal.docs.isEmpty) {
      meal.favorite = true;
      await db
          .collection("users")
          .doc(userdata.id)
          .collection("favorite")
          .withConverter(
            fromFirestore: MealDetial.fromFirestore,
            toFirestore: (MealDetial meald, options) => meald.toFirestore(),
          )
          .add(meal)
          .then((value) => meal.id = value.id);
      await db
          .collection("users")
          .doc(userdata.id)
          .collection("favorite")
          .withConverter(
            fromFirestore: MealDetial.fromFirestore,
            toFirestore: (MealDetial meald, options) => meald.toFirestore(),
          )
          .doc(meal.id)
          .update(meal.toFirestore());
    } else {
      meal.favorite = false;
      await db
          .collection("users")
          .doc(userdata.id)
          .collection("favorite")
          .withConverter(
            fromFirestore: MealDetial.fromFirestore,
            toFirestore: (MealDetial meald, options) => meald.toFirestore(),
          )
          .doc(fmeal.docs[0].data().id)
          .delete();
    }
    await getFavorite();
    // await FilterMeals();
    addfavorIteMealProcces = false;

    emit(AddFavoriteState());
  }

  getFavorite() async {
    print("StartFavorite");
    favoriteMeals.clear();
    var getfavo = await db
        .collection("users")
        .doc(userdata.id)
        .collection("favorite")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .get();
    for (var doc in getfavo.docs) {
      favoriteMeals.add(doc.data());
    }
    emit(GetFAvoriteState());
  }

  getMyMeal() async {
    var meals = await db
        .collection("Meals")
        .where("userid", isEqualTo: userdata.accessToken)
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mymeal, options) => mymeal.toFirestore(),
        )
        .get();
    myMeal.clear();
    for (var meal in meals.docs) {
      myMeal.add(meal.data());
    }
    emit(GetMyMealState());
  }

  getMyFeedbacks({required String id}) async {
    var getFeedbacks = await db
        .collection("Feedback")
        .where('id', isEqualTo: id)
        .withConverter(
          fromFirestore: FeedbackModel.fromFirestore,
          toFirestore: (FeedbackModel feedbackModel, options) =>
              feedbackModel.toFirestore(),
        )
        .get();
    myFeedbacks.clear();
    for (var Feeds in getFeedbacks.docs) {
      myFeedbacks.add(Feeds.data());
    }
    emit(GetMyFeedbackState());
  }
}
