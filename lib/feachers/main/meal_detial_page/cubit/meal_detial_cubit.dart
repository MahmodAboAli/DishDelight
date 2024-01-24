
import 'package:DISH_DELIGhTS/core/userdata.dart';
import 'package:DISH_DELIGhTS/feachers/main/main_page/feachers/home/cubit/home_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../main_page/feachers/home/models/shop_list.dart';
import '../models/meal_detial_model.dart';

part 'meal_detial_state.dart';

class MealDetialCubit extends Cubit<MealDetialState> {
  MealDetialCubit() : super(MealDetialInitial());
  static MealDetialCubit get(context) => BlocProvider.of(context);
  var db = FirebaseFirestore.instance;
  MealDetial currMealDetial = MealDetial();

  int pageIndex = 0;
  ChangePageIndex(int index) {
    pageIndex = index;
    emit(ChangePageState());
  }

  bool addfavoritemealprocces = false;
  bool userMeal = false;
  addfavoriteMeal(MealDetial meal,context, {bool userMealfavorite = false}) async {
    var homeCubit = HomeCubit.get(context);
    addfavoritemealprocces = true;
    if (userMealfavorite == true) {
      meal.favorite = false;
      userMeal = false;
    } else {
      meal.favorite = true;
      userMeal = true;
    }
    emit(ChangeCategoryState());
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
    await homeCubit.getFavorite();
    // await FilterMeals();
    addfavoritemealprocces = false;

    emit(AddFavoriteState());
  }

  // List<Needs_Meal> valueOfNeeds = [];

  changeNeedsAmount(double Amount, int index) {
    if (Amount + valueOfNeeds[index].need >= 0)
      valueOfNeeds[index].need += Amount;
    emit(ChangeNeedsAmountState());
  }

  addNeeds(String name, double need) async {
    try {
      ShopList tool = ShopList(title: name, needs: need);
      var needs = await db
          .collection("users")
          .doc(userdata.id)
          .collection("needs")
          .withConverter(
            fromFirestore: ShopList.fromFirestore,
            toFirestore: (ShopList shopList, options) => shopList.toFirestore(),
          )
          .where("title", isEqualTo: name)
          .get();

      if (needs.docs.isEmpty) {
        await db
            .collection("users")
            .doc(userdata.id)
            .collection("needs")
            .withConverter(
              fromFirestore: ShopList.fromFirestore,
              toFirestore: (ShopList shopList, options) =>
                  shopList.toFirestore(),
            )
            .add(tool)
            .then((value) => tool.id = value.id);
        await db
            .collection("users")
            .doc(userdata.id)
            .collection("needs")
            .withConverter(
              fromFirestore: ShopList.fromFirestore,
              toFirestore: (ShopList shopList, options) =>
                  shopList.toFirestore(),
            )
            .doc(tool.id)
            .update(tool.toFirestore());
      } else {
        var updatetool = await db
            .collection("users")
            .doc(userdata.id)
            .collection("needs")
            .withConverter(
              fromFirestore: ShopList.fromFirestore,
              toFirestore: (ShopList shopList, options) =>
                  shopList.toFirestore(),
            )
            .where("title", isEqualTo: name)
            .get();
        ShopList tooll = updatetool.docs[0].data();
        tool =
            ShopList(title: name, needs: tool.needs! + tooll.needs!.toDouble());
        emit(AddNeedState());
        await db
            .collection("users")
            .doc(userdata.id)
            .collection("needs")
            .withConverter(
              fromFirestore: ShopList.fromFirestore,
              toFirestore: (ShopList shopList, options) =>
                  shopList.toFirestore(),
            )
            .doc(tooll.id)
            .update(tool.toFirestore());
      }
      // getShopList();
      emit(AddNeedState());
    } catch (e) {
      print(e);
    }
  }
}
