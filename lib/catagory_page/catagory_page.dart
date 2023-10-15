import 'package:DISH_DELIGhTS/meal_detial/meal_detia_screenl.dart';
import 'package:DISH_DELIGhTS/model/meal_detial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/meal_cubit.dart';

class CatagoryPage extends StatelessWidget {
  const CatagoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color y = const Color.fromRGBO(255, 183, 77, 1);
    Color b = const Color.fromRGBO(55, 71, 79, 1);
    Color w = const Color.fromRGBO(252, 252, 252, 1);
    Widget Unite(
        {required double rate,
        required MealDetial meal,
        required String image,
        required String time,
        required String name}) {
      return BlocConsumer<MealCubit, MealState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = MealCubit.get(context);
          return Container(
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
                  child: GestureDetector(
                    onTap: () async {
                      await cubit.initneeds(meal);
                      await cubit.getuserMeal(meal.title ?? "");
                      await cubit.getMealFeedbacks(id: meal.id ?? "");
                      await cubit.getMealDetial(id: meal.id ?? "");
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MealDetialScreen(meal: meal),
                      ));
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      width: double.infinity,
                      height: 95.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                        ),
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
                        rate.round().toString(),
                        style: const TextStyle(
                          color: Color.fromRGBO(127, 127, 127, 1),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
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
          appBar: AppBar(
            backgroundColor: y,
            title: Text(
              'All Catagories',
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
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 21),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0411,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: cubit.currMeal.length,
              itemBuilder: (BuildContext context, int index) {
                return Unite(
                    meal: cubit.currMeal[index],
                    image: cubit.currMeal[index].src ?? '',
                    rate: cubit.currMeal[index].rate ?? 0,
                    name: cubit.currMeal[index].title ?? 'title',
                    time: cubit.currMeal[index].time ?? "15");
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
        );
      },
    );
  }
}
