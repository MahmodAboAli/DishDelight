import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:star_rating/star_rating.dart';

import '../../../../../../core/colors.dart';
import '../../../../../../core/userdata.dart';

// ignore: must_be_immutable
class Feed_Back extends StatelessWidget {
  Color y = const Color.fromRGBO(255, 183, 77, 1);
  Color b = const Color.fromRGBO(55, 71, 79, 1);
  Color w = const Color.fromRGBO(252, 252, 252, 1);
  Color g = const Color.fromRGBO(247, 247, 247, 1);
  @override
  Widget build(BuildContext context) {
    // List<String> li = [
    //   'Main',
    //   'Aprrtie',
    //   'Sweetes',
    //   'Drinks',
    //   'Candies',
    //   'vegin'
    // ];

    return SafeArea(
      child: Scaffold(backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
        body: Column(
          children: [
            Container(
              color: y,
              padding: EdgeInsets.only(top: 40.h, bottom: 10.h, left: 10.w),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                    child: const Text(
                      'Feedback',
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
                ],
              ),
            ),
            feedbacks.isEmpty
                ? Container(
                    margin: EdgeInsets.only(top: 300.h),
                    child: const Text("There aren't any feedbacks"))
                : Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.only(top: 27.h, left: 18.w, right: 18.w),
                      child: ListView(
                        children: [
                          ...feedbacks
                              .map((e) => InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 27.h),
                                      decoration: BoxDecoration(
                                          color: w,
                                          borderRadius:
                                              BorderRadius.circular(16).w,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0),
                                              offset: Offset(-3, -3),
                                              blurRadius: 7,
                                              spreadRadius: 0,
                                            ),
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.25),
                                              offset: Offset(1, 3),
                                              blurRadius: 8,
                                              spreadRadius: 0,
                                            ),
                                          ]),
                                      width: 359.w,
                                      height: 348.h,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 17.h, horizontal: 26.w),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 150.w,
                                                  child: Text(
                                                    e.name ?? "Unknown",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 22.sp,
                                                        color: b,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  child: StarRating(
                                                    starSize: 20.w,
                                                    color: const Color(orange),
                                                    length: 5,
                                                    rating: e.rate ?? 0,
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color.fromRGBO(
                                                    244, 244, 244, 1),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(e.title ?? "title",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              255, 183, 7, 1))),
                                                  SizedBox(
                                                    width: 80.w,
                                                  ),
                                                  Container(
                                                    width: 1.w,
                                                    height: 28.h,
                                                    color: Color.fromRGBO(
                                                        164, 164, 164, 1),
                                                  ),
                                                  Text(
                                                    e.section ?? "Main",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            164, 164, 164, 1)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.96.h,
                                            ),
                                            Container(
                                                height: 70.h,
                                                width: double.infinity,
                                                child: SingleChildScrollView(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  child: Text(
                                                    e.descreption ?? "nothing",
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            55, 71, 79, 1),
                                                        fontSize: 15),
                                                  ),
                                                )),
                                            Expanded(
                                              child: Container(
                                                width: double.infinity,
                                                // height: 162.h,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                                12)
                                                            .w,
                                                    child: Image.network(
                                                      '${e.src}',
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: const Color.fromARGB(255, 248, 198, 132),
        //   onPressed: () async {
        //     await cubit.getMeal(
        //         section: cubit.curricepFeedback, title: cubit.ricepfeedback);
        //     sheet(context, cubit.userdata.accessToken ?? "",
        //         cubit.feedbackMealId ?? "");
        //   },
        //   child: const Icon(
        //     Icons.message,
        //     color: Colors.orange,
        //   ),
        // ),
      ),
    );
  }
}
