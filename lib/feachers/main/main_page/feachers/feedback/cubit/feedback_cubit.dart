import 'package:DISH_DELIGhTS/core/userdata.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../meal_detial_page/models/meal_detial_model.dart';
import '../../home/models/feedback_model.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(FeedbackInitial());
  static FeedbackCubit get(context) => BlocProvider.of(context);
  final db = FirebaseFirestore.instance;
  bool publishprosses = false;
  double rate = 0;
  MealDetial mealforFeedback = MealDetial();
  String? feedbackMealId;
  String curricepFeedback = "Main";
  

  

  String ricepfeedback = '';

  void recipe(String x) {
    ricepfeedback = x;
    emit(ChangericepState());
  }

// ! for remove because it's not nessesry
  List<String> currRicepFeedbackList = [''];

  changeFeedbackCategory(String z) {
    curricepFeedback = z;
    if (z == "Main") {
      currRicepFeedbackList.clear();
      for (MealDetial x in mainMeals) {
        currRicepFeedbackList.add(x.title ?? "null");
      }
      ricepfeedback = currRicepFeedbackList[0];
      if (currRicepFeedbackList.isEmpty) {
        currRicepFeedbackList.add('');
      }
      // ricepfeedback = MainMeal[0].title!;
    }
    if (z == "Sweetes") {
      currRicepFeedbackList.clear();
      for (MealDetial x in sweetesMeals) {
        currRicepFeedbackList.add(x.title ?? "null");
      }
      ricepfeedback = currRicepFeedbackList[0];
      if (currRicepFeedbackList.isEmpty) {
        currRicepFeedbackList.add('');
      }
    }
    if (z == "Drinks") {
      currRicepFeedbackList.clear();
      for (MealDetial x in drinksMeals) {
        currRicepFeedbackList.add(x.title ?? "null");
        ricepfeedback = currRicepFeedbackList[0];
      }
      if (currRicepFeedbackList.isEmpty) {
        currRicepFeedbackList.add('');
      }
    }
    if (z == "Candies") {
      currRicepFeedbackList.clear();
      for (MealDetial x in candiesMeals) {
        currRicepFeedbackList.add(x.title ?? "null");
        ricepfeedback = currRicepFeedbackList[0];
      }
      if (currRicepFeedbackList.isEmpty) {
        currRicepFeedbackList.add('');
      }
    }
    if (z == "Vegin") {
      currRicepFeedbackList.clear();
      for (MealDetial x in veginMeals) {
        currRicepFeedbackList.add(x.title ?? "null");
        ricepfeedback = currRicepFeedbackList[0];
      }
      if (currRicepFeedbackList.isEmpty) {
        currRicepFeedbackList.add('');
      }
    }
    if (z == "Aprrtie") {
      currRicepFeedbackList.clear();
      for (MealDetial x in aprrtieMeals) {
        currRicepFeedbackList.add(x.title ?? "null");
        ricepfeedback = currRicepFeedbackList[0];
      }
      if (currRicepFeedbackList.isEmpty) {
        currRicepFeedbackList.add('');
      }
    }
    ricepfeedback = currRicepFeedbackList[0];

    emit(ChangeRicepState());
  }


  selectRate(double value) {
    rate = value;
    emit(ChangeValueState());
  }

  
  getMealforFeedback({required String tit, required String name}) async {
    var Mff = await db
        .collection("Meals")
        .where("title", isEqualTo: name)
        .where("section", isEqualTo: tit)
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealforFeedback, options) =>
              mealforFeedback.toFirestore(),
        )
        .get();
    mealforFeedback = Mff.docs[0].data();
    emit(GetMealforFeedbackState());
  }


// ! have to change
  getMeal({required String section, required String title}) async {
    var meal = await db
        .collection("Meals")
        .where('section', isEqualTo: section)
        .where('title', isEqualTo: title)
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealdetial, options) =>
              mealdetial.toFirestore(),
        )
        .get();
    feedbackMealId = meal.docs[0].data().id;
    emit(GetMealState());
    emit(LoadingMealState());
  }

  
  addrate(double rate, MealDetial meal) async {
    int x = meal.numOfrate ?? 0;
    double y = meal.rate ?? 2;

    meal.rate = (y * x + rate) / (x + 1);
    meal.numOfrate = x + 1;
    emit(ChangeValueState());
    await db.collection("Meals").doc(meal.id).update(meal.toFirestore());
    // await getTrendMeal();
    emit(AddRateState());
    emit(LoadingMealState());
  }

  publishFeedback(
      {required String descreption1,
      required String id,
      required String mealId}) async {
    publishprosses = true;
    emit(LoadingMealState());
    await getMealforFeedback(tit: curricepFeedback, name: ricepfeedback);
    await addrate(rate, mealforFeedback);
    await getMeal(section: curricepFeedback, title: ricepfeedback);
    // await getProfile();
    FeedbackModel feedback = FeedbackModel(
      descreption: descreption1,
      photo: userdata.photoUrl,
      src: str,
      title: ricepfeedback,
      rate: rate,
      id: id,
      mealId: feedbackMealId,
      section: curricepFeedback,
      name: userdata.displayName,
    );
    await db
        .collection("Feedback")
        .withConverter(
          fromFirestore: FeedbackModel.fromFirestore,
          toFirestore: (FeedbackModel feedback, options) =>
              feedback.toFirestore(),
        )
        .add(feedback);
    // await getData();
    // await getFeedbacks();
    str = '';
    rate = 0;
    publishprosses = false;
    emit(PublishFeedbackState());
  }
}
