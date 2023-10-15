import 'package:DISH_DELIGhTS/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:star_rating/star_rating.dart';

import '../../../cubit/meal_cubit.dart';

class ProFeed extends StatelessWidget {
  Color y = const Color.fromRGBO(255, 183, 77, 1);
  Color b = const Color.fromRGBO(55, 71, 79, 1);
  Color w = const Color.fromRGBO(252, 252, 252, 1);
  Color g = const Color.fromRGBO(247, 247, 247, 1);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealCubit.get(context);
        var a = cubit.MyFeedbacks;
        return ListView(
          children: [
            ...a
                .map((e) => InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(bottom: 27.h),
                        decoration: BoxDecoration(
                            color: w,
                            borderRadius: BorderRadius.circular(16).w,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(255, 255, 255, 0),
                                offset: Offset(-3, -3),
                                blurRadius: 7,
                                spreadRadius: 0,
                              ),
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                offset: Offset(1, 3),
                                blurRadius: 8,
                                spreadRadius: 0,
                              ),
                            ]),
                        width: 359.w,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 17.h, horizontal: 26.w),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.name ?? "Unknown",
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        color: b,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    child: StarRating(
                                      length: 5,
                                      color: const Color(orange),
                                      rating: e.rate!.round().toDouble(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16.11.h,
                              ),
                              Container(
                                width: 309.w,
                                height: 28.7.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromRGBO(244, 244, 244, 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(e.title ?? "title",
                                          style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 183, 7, 1))),
                                      SizedBox(
                                        width: 80.w,
                                      ),
                                      Container(
                                        width: 1.w,
                                        height: 28.h,
                                        color: const Color.fromRGBO(
                                            164, 164, 164, 1),
                                      ),
                                      Text(
                                        e.section ?? "Main",
                                        style: const TextStyle(
                                            color: Color.fromRGBO(
                                                164, 164, 164, 1)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.96.h,
                              ),
                              Container(
                                  width: 307,
                                  height: 60,
                                  child: Text(
                                    e.descreption ?? "null",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(55, 71, 79, 1),
                                        fontSize: 15),
                                  )),
                              Container(
                                width: 309.w,
                                height: 162.h,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12).w,
                                    child: Image.network(
                                      '${e.src}',
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ],
        );
      },
    );
  }
}
