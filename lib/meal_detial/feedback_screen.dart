import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:star_rating/star_rating.dart';

import '../core/colors.dart';
import '../cubit/meal_cubit.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MealCubit.get(context);
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: cubit.MealFeedbacks.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(4.w),
              margin: EdgeInsets.only(bottom: 10.h),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.black,
                      offset: Offset(0, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(
                              cubit.MealFeedbacks[index].photo ?? ''),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(cubit.MealFeedbacks[index].name ?? 'Unknown'),
                        Spacer(),
                        StarRating(
                          starSize: 20.w,
                          color: const Color(orange),
                          length: 5,
                          rating: cubit.MealFeedbacks[index].rate ?? 0,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.w),
                      child: Text(
                        cubit.MealFeedbacks[index].descreption ?? "",
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Color(Grey)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ]),
            );
          },
        );
      },
    );
  }
}
