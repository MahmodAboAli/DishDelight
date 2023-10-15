import 'package:DISH_DELIGhTS/model/meal_detial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubit/meal_cubit.dart';
import '../../../meal_detial/meal_detia_screenl.dart';

class ProRecipe extends StatelessWidget {
  Color y = const Color.fromRGBO(255, 183, 77, 1);
  Color b = const Color.fromRGBO(55, 71, 79, 1);
  Color w = const Color.fromRGBO(252, 252, 252, 1);
  Color g = const Color.fromRGBO(247, 247, 247, 1);
  Widget Unite(
      {required String image,
      required String time,
      required MealDetial e,
      required BuildContext context,
      required String title,
      int rate = 3}) {
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MealCubit.get(context);
        return GestureDetector(
          onTap: () async {
            await cubit.initneeds(e);
            await cubit.getuserMeal(e.title ?? "");
            await cubit.getMealFeedbacks(id: e.title ?? "");
            await cubit.getMealDetial(id: e.title ?? "");
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MealDetialScreen(meal: e),
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
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      height: 95.h,
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 13.0, top: 8.h),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 14.sp, fontWeight: FontWeight.w500, color: b),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14, top: 12.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 18,
                        color: y,
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          color: Color.fromRGBO(127, 127, 127, 1),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.star_border,
                        size: 18,
                        color: y,
                      ),
                      Text(
                        rate.toString(),
                        style: TextStyle(
                          color: Color.fromRGBO(127, 127, 127, 1),
                        ),
                      ),
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        MealCubit cubit = MealCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 21),
          child: GridView.builder(
            itemCount: cubit.MyMeal.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 170.w,
                // childAspectRatio: 1.w,
                mainAxisExtent: 150.w,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 10.w),
            itemBuilder: (context, index) => Unite(
              image: cubit.MyMeal[index].src ?? "",
              e: cubit.MyMeal[index],
              context: context,
              time: cubit.MyMeal[index].time ?? '',
              title: cubit.MyMeal[index].title ?? '',
            ),
          ),
        );
      },
    );
  }
}
