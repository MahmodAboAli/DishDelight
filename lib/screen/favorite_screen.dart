import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/meal_cubit.dart';
import '../meal_detial/meal_detia_screenl.dart';
import '../model/meal_detial.dart';

// RatingBar.builder(itemSize: 20,
//                               initialRating: 3,
//                               minRating: 1,
//                               direction: Axis.horizontal,
//                               allowHalfRating: true,
//                               itemCount: 5,
//                               itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                               itemBuilder: (context, _) => Icon(
//                                 Icons.star,
//                                 color: Colors.amber,
//                               ),
//                               onRatingUpdate: (rating) {
//                                 print(rating);
//                               },
//                             ),
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color y = const Color.fromRGBO(255, 183, 77, 1);
    Color b = const Color.fromRGBO(55, 71, 79, 1);
    Color w = const Color.fromRGBO(252, 252, 252, 1);
    Widget Unite(
        {required String image,
        required String time,
        required double rate,
        required String name,
        required MealDetial meal,
        required context}) {
      var cubit = MealCubit.get(context);
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
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                            if (cubit.addfavoritemealprocces) {
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
    }

    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MealCubit.get(context);
        return Scaffold(
          backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
          // appBar: AppBar(
          //   backgroundColor: y,
          //   title:
          // ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50.h, bottom: 20.h, left: 10.w),
                width: double.infinity,
                color: y,
                child: Text(
                  'My favorite meals',
                  style: TextStyle(
                      color: b,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      shadows: const [
                        Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4.0,
                        )
                      ]),
                ),
              ),
              cubit.favoriteMeals.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 300.h),
                      child: const Text("There aren't any favorite meal"))
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 21),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.0411,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20
                                  ),
                          itemCount: cubit.favoriteMeals.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Unite(
                                context: context,
                                rate: cubit.favoriteMeals[index].rate ?? 0,
                                meal: cubit.favoriteMeals[index],
                                image: cubit.favoriteMeals[index].src ?? '',
                                name:
                                    cubit.favoriteMeals[index].title ?? 'title',
                                time: cubit.favoriteMeals[index].time ?? "15");
                          },
                        ),
                        //  GridView(
                        //   semanticChildCount: 2,
                        //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        //       maxCrossAxisExtent: 300,
                        //       childAspectRatio: 1.0411,
                        //       crossAxisSpacing: 20,
                        //       mainAxisSpacing: 20
                        //       ),
                        //   children: [
                        //     Unite(),

                        //   ],
                        // ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
