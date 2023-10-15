import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rating_bar_flutter/rating_bar_flutter.dart';
import 'package:star_rating/star_rating.dart';

import '../../core/colors.dart';
import '../../cubit/meal_cubit.dart';
import '../../model/feedback_model.dart';

class Feed_Back extends StatelessWidget {
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
        void showPicker(context) {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext ctx) {
                return SafeArea(
                    child: Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text("Gallery"),
                      onTap: () async {
                        await cubit.imgFromGallery(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo_camera),
                      title: const Text("Camera"),
                      onTap: () async {
                        await cubit.imgFromGallery(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
              });
        }

        void sheet(context, String id, String mealId) {
          showModalBottomSheet(
              barrierColor: Colors.white.withOpacity(0.4),
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(26).w,
                  topRight: const Radius.circular(26).w,
                ),
              ),
              builder: (context) {
                return BlocConsumer<MealCubit, MealState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    var cub = MealCubit.get(context);
                    TextEditingController descriptionController =
                        cubit.descriptionController;
                    return Container(
                      margin: const EdgeInsets.all(22).w,
                      height: 375.h,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add Feedback',
                            style: TextStyle(
                                fontSize: 18,
                                color: b,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10).w,
                            child: const Divider(
                              color: Colors.black,
                              height: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cub.userdata.displayName ?? "Unknown",
                                  style: TextStyle(
                                      color: y,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                RatingBarFlutter(
                                    size: 20.w,
                                    onRatingChanged: (value) async {
                                      await cub.selectRate(value!);
                                    },
                                    filledColor: const Color(orange),
                                    filledIcon: Icons.star,
                                    emptyIcon: Icons.star_outline),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 120.w,
                                height: 27.h,
                                decoration: BoxDecoration(
                                  color: g,
                                  borderRadius: BorderRadius.circular(6).w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Category : ',
                                      style: TextStyle(
                                          color: b,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10.sp),
                                    ),
                                    DropdownButton(
                                        iconEnabledColor: y,
                                        value: cub.curricepFeedback,
                                        items: cub.li
                                            .map((e) => DropdownMenuItem(
                                                  value: e,
                                                  onTap: () {
                                                    cub.ChangeFeedbackCategory(
                                                        e);
                                                  },
                                                  child: Text(
                                                    e,
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: b),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (val) {
                                          cub.ChangeFeedbackCategory(val!);
                                        }),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 11).w,
                                width: 215.w,
                                height: 27.h,
                                decoration: BoxDecoration(
                                  color: g,
                                  borderRadius: BorderRadius.circular(6).w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Recipe name : ',
                                      style: TextStyle(
                                          color: b,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10.sp),
                                    ),
                                    DropdownButton(
                                        iconEnabledColor: y,
                                        value: cub.ricepfeedback,
                                        items: cub.currRicepFeedbackList
                                            .map((e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: b),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (val) {
                                          cub.recipe(val!);
                                        }),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: 190.w,
                            margin: const EdgeInsets.only(top: 11, bottom: 4),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Add photo',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Add Opinion',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 23.h),
                            child: Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      color: g,
                                      width: 120.w,
                                      height: 98.h,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          showPicker(context);
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: y,
                                          size: 20,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  width: 14.w,
                                ),
                                Container(
                                  width: 213.w,
                                  height: 98.h,
                                  color: g,
                                  child: TextField(
                                    controller: descriptionController,
                                    maxLines: 4,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(fontSize: 8.sp),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: g),
                                          borderRadius: BorderRadius.zero),
                                      hintText:
                                          'what do you think about the recipe',
                                      hintStyle: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 343.w,
                            height: 47.h,
                            color: y,
                            child: OutlinedButton(
                                onPressed: () async {
                                  if (state is loadingMealState) {
                                  } else {
                                    if (cub.str == '') {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AlertDialog(
                                            title: Text("There are an error"),
                                            icon: Icon(Icons.error),
                                            content: Text(
                                                "you have to add an image"),
                                          );
                                        },
                                      );
                                    } else {
                                      if (cub.ricepfeedback == '') {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              title: Text("There are an error"),
                                              icon: Icon(Icons.error),
                                              content:
                                                  Text("select Recipe name"),
                                            );
                                          },
                                        );
                                      } else {
                                        await cub.PublishFeedback(
                                            id: id,
                                            mealId: mealId,
                                            descreption1:
                                                descriptionController.text);
                                        Navigator.of(context).pop();
                                      }
                                    }
                                  }
                                },
                                child: (cub.Publishprosses)
                                    ? CircularProgressIndicator()
                                    : Text(
                                        'Puplish',
                                        style: TextStyle(
                                            color: w,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w500),
                                      )),
                          ),
                        ],
                      ),
                    );
                  },
                );
              });
        }

        List<FeedbackModel> aa = cubit.Feedbacks;
        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: y,
              onPressed: () {
              sheet(context, cubit.userdata.accessToken ?? "",
              cubit.feedbackMealId ?? "");
              },
              child:
                  Image(height: 30.h, image: AssetImage('assest/message.png')),
            ),
            backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
            // appBar: AppBar(
            //   title: const Text('FeedBack'),
            //   backgroundColor: y,
            //   actions: [
            //   ],
            // ),
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
                      // Container(
                      //   padding: const EdgeInsets.only(
                      //       top: 10, right: 20, bottom: 10, left: 10),
                      //   child: GestureDetector(
                      //       onTap: () async {
                      //       },
                      //       child: Image(
                      //           height: 30.h,
                      //           image: AssetImage('assest/message.png'))),
                      // ),
                    ],
                  ),
                ),
                aa.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(top: 300.h),
                        child: const Text("There aren't any feedbacks"))
                    : Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 27.h, left: 18.w, right: 18.w),
                          child: ListView(
                            children: [
                              ...aa
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
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.25),
                                                  offset: Offset(1, 3),
                                                  blurRadius: 8,
                                                  spreadRadius: 0,
                                                ),
                                              ]),
                                          width: 359.w,
                                          height: 348.h,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 17.h,
                                                horizontal: 26.w),
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 22.sp,
                                                            color: b,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: StarRating(
                                                        starSize: 20.w,
                                                        color:
                                                            const Color(orange),
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                              color: Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      183,
                                                                      7,
                                                                      1))),
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
                                                            color:
                                                                Color.fromRGBO(
                                                                    164,
                                                                    164,
                                                                    164,
                                                                    1)),
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
                                                    child:
                                                        SingleChildScrollView(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      child: Text(
                                                        e.descreption ??
                                                            "nothing",
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    55,
                                                                    71,
                                                                    79,
                                                                    1),
                                                            fontSize: 15),
                                                      ),
                                                    )),
                                                Expanded(
                                                  child: Container(
                                                    width: double.infinity,
                                                    // height: 162.h,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                    .circular(
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
      },
    );
  }
}
