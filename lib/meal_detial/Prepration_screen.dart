import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/colors.dart';
import '../model/meal_detial.dart';

class PreparationScreen extends StatelessWidget {
  final MealDetial meal;
  const PreparationScreen({super.key, required this.meal});

  @override     
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: meal.steps!.length,
        itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              children: [
                Text(
                  "${index + 1}.",
                  style: const TextStyle(color: Color(orange)),
                ),
                Text(
                  "${meal.steps![index]}",
                  style: TextStyle(color: Color(0xFF1E1E1E)),
                )
              ],
            )),
      ),
    );
  }
}
