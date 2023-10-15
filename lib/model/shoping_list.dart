import 'package:DISH_DELIGhTS/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/meal_cubit.dart';
import 'meels.dart';

class distDelight {
  late final String name;
  late final String model;
  late final String dish;
  int counter;
  distDelight({
    required this.name,
    required this.counter,
    required this.model,
    required this.dish,
  });
}

class shopingList extends StatefulWidget {
  const shopingList({Key? key}) : super(key: key);

  @override
  State<shopingList> createState() => _shopingListState();
}

class _shopingListState extends State<shopingList> {
  @override
  Widget build(BuildContext context) {
    Color y = const Color.fromRGBO(255, 183, 77, 1);

    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealCubit.get(context);

        Widget BuildItem(Needs_Meal dish, int index) {
          return Dismissible(
            onDismissed: (direction) async {
              cubit.MyshopList.removeAt(index);
              if (!cubit.removeneedsprocces) {
                await cubit.removeNeeds(dish);
              }
            },
            key: Key(dish.name),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dish.name,
                            style: TextStyle(
                                fontSize: 20.w, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '${dish.need}',
                              style: TextStyle(
                                fontSize: 20.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50.h, bottom: 20.h, left: 10.w),
                width: double.infinity,
                color: y,
                child: const Text(
                  'Shoping List',
                  style: TextStyle(
                      color: Color(black),
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      shadows: [
                        Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4.0,
                        )
                      ]),
                ),
              ),
              cubit.MyshopList.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 300.h),
                      child: const Text("There aren't any needs"))
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              BuildItem(cubit.MyshopList[index], index),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10.h,
                          ),
                          itemCount: cubit.MyshopList.length,
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
