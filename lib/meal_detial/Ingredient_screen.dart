import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/meal_cubit.dart';
import '../model/meal_detial.dart';

class IngredientScreen extends StatelessWidget {
  final MealDetial meal;
  const IngredientScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealCubit.get(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: (const Text(
                '*for one person',
                style: TextStyle(color: Color(0xFF707070), fontFamily: 'Glory'),
              )),
            ),
            ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 4.h,
              ),
              shrinkWrap: true,
              itemCount: meal.ingredient!.length,
              itemBuilder: (context, index) => (Text(
                '${meal.ingredient![index]} ${meal.valueOfIngredient?[index] ?? "nothing"}',
                style:
                    TextStyle(color: const Color(0xFF323232), fontSize: 18.w),
              )),
              physics: const NeverScrollableScrollPhysics(),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: (const Text(
                'Shopping cart',
                style: TextStyle(
                    color: Color(0xFF37474F),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Poppins'),
              )),
            ),
            // Spacer(),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: meal.ingredient!.length,
              itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E7E7),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 20.w),
                          child: Text(
                            meal.ingredient![index],
                            style: TextStyle(fontSize: 20.w),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              await cubit.changeNeedsAmount(-0.25, index);
                            },
                            child: const Icon(
                              Icons.remove,
                              size: 25,
                              color: Color(0XFFFFA01E),
                            ),
                          ),
                          Text(
                            cubit.valueOfNeeds[index].need.toString(),
                            style: const TextStyle(
                                color: Color(0XFF000000),
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                fontFamily: 'Poppins'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await cubit.changeNeedsAmount(0.25, index);
                            },
                            child: const Icon(
                              Icons.add,
                              size: 25,
                              color: Color(0XFFFFA01E),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                right: 21.w,
                left: 21.w,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFAC33),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Start adding the needs')));
                  for (int i = 0; i < meal.ingredient!.length; i++) {
                    await cubit.addNeeds(
                        meal.ingredient![i], cubit.valueOfNeeds[i].need);
                  }
                  // Navigator.of(context).pop();
                },
                child: Text(
                  'Save ',
                  style: TextStyle(
                      color: const Color(0XFFFFFFFF),
                      fontSize: 20.w,
                      fontFamily: 'Tajawal'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
