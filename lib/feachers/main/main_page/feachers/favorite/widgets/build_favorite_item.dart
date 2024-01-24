import 'package:DISH_DELIGhTS/feachers/main/main_page/feachers/home/cubit/home_cubit.dart';
import 'package:DISH_DELIGhTS/feachers/main/meal_detial_page/models/meal_detial_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../meal_detial_page/screens/meal_detia_screenl.dart';

// ignore: must_be_immutable
class BuildFavoriteItem extends StatelessWidget {
  Color y = const Color.fromRGBO(255, 183, 77, 1);
  Color b = const Color.fromRGBO(55, 71, 79, 1);
  Color w = const Color.fromRGBO(252, 252, 252, 1);
  BuildFavoriteItem(
      {super.key,
      required this.image,
      required this.time,
      required this.rate,
      required this.name,
      required this.meal});
  final String image;
  final String time;
  final double rate;
  final String name;
  final MealDetial meal;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return GestureDetector(
          onTap: () async {
            await cubit.initneeds(meal);
            await cubit.getuserMeal(meal.title ?? "");
            await cubit.getMealFeedbacks(id: meal.title ?? "");
            await cubit.getMealDetial(id: meal.title ?? "");
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MealDetialScreen(meal: meal),
            ));
          },
          child: Container(
            decoration: BoxDecoration(
              color: w,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    offset: Offset(-3, -3),
                    spreadRadius: 0,
                    blurRadius: 7),
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(1, 3),
                    spreadRadius: 0,
                    blurRadius: 8)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    width: double.infinity,
                    height: 95,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0, top: 8),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500, color: b),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14, top: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 18,
                        color: y,
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          color: Color.fromRGBO(127, 127, 127, 1),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.star_border,
                        size: 18,
                        color: y,
                      ),
                      Text(
                        '${rate.round()}',
                        style: const TextStyle(
                          color: Color.fromRGBO(127, 127, 127, 1),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: GestureDetector(
                            onTap: () async {
                              if (cubit.addfavorIteMealProcces) {
                              } else {
                                await cubit.addfavoriteMeal(meal,
                                    userMealfavorite: meal.favorite ?? false);
                              }
                            },
                            child: meal.favorite == true
                                ? const Icon(
                                    Icons.favorite,
                                  )
                                : const Icon(Icons.favorite_border_outlined)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
