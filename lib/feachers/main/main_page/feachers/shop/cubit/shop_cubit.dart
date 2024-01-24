
import 'package:DISH_DELIGhTS/core/userdata.dart';
import 'package:DISH_DELIGhTS/cubit/meal_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../home/models/needs_model.dart';
import '../../home/models/shop_list.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  static ShopCubit get(context) => BlocProvider.of(context);
  final db = FirebaseFirestore.instance;
  bool removeneedsprocces = false;
  removeNeeds(Needs_Meal needs_meal,BuildContext context) async {
  var mealCubit = MealCubit.get(context);

    removeneedsprocces = true;
    emit(LoadingMealState());
    var removemeal = await db
        .collection("users")
        .doc(userdata.id)
        .collection("needs")
        .where('title', isEqualTo: needs_meal.name)
        .withConverter(
          fromFirestore: ShopList.fromFirestore,
          toFirestore: (ShopList shopList, options) => shopList.toFirestore(),
        )
        .get();
    await db
        .collection("users")
        .doc(userdata.id)
        .collection("needs")
        .doc(removemeal.docs[0].data().id)
        .delete();
    // emit(ChangeState());
    mealCubit.getShopList();
    removeneedsprocces = false;
    emit(RemoveNeedsState());
  }
}
