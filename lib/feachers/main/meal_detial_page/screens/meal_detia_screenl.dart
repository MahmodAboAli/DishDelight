import 'package:DISH_DELIGhTS/core/userdata.dart';
import 'package:DISH_DELIGhTS/cubit/meal_cubit.dart';
import 'package:DISH_DELIGhTS/feachers/main/main_page/feachers/feedback/cubit/feedback_cubit.dart';
import 'package:DISH_DELIGhTS/feachers/main/meal_detial_page/cubit/meal_detial_cubit.dart';
import 'package:DISH_DELIGhTS/feachers/main/meal_detial_page/widgets/Ingredient_screen.dart';
import 'package:DISH_DELIGhTS/feachers/main/meal_detial_page/widgets/Prepration_screen.dart';
import 'package:DISH_DELIGhTS/feachers/main/meal_detial_page/widgets/feedback_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rating_bar_flutter/rating_bar_flutter.dart';
import 'package:star_rating/star_rating.dart';

import '../../../../core/colors.dart';
import '../models/meal_detial_model.dart';

// ignore: must_be_immutable
class MealDetialScreen extends StatelessWidget {
  final MealDetial meal;
  MealDetialScreen({super.key, required this.meal});
  @override
  Widget build(BuildContext context) {
    Color y = const Color.fromRGBO(255, 183, 77, 1);
    Color b = const Color.fromRGBO(55, 71, 79, 1);
    Color w = const Color.fromRGBO(252, 252, 252, 1);
    Color g = const Color.fromRGBO(247, 247, 247, 1);
    Widget TabBarWidget() {
      return BlocBuilder<MealDetialCubit, MealDetialState>(
        builder: (context, state) {
          var cubit = MealDetialCubit.get(context);
          return DefaultTabController(
            length: 3,
            child: TabBar(
              onTap: cubit.ChangePageIndex,
              labelColor: Colors.orange,
              indicatorColor: Colors.orange,
              tabs: [
                const Tab(
                  text: "Ingredients",
                ),
                const Tab(
                  text: "Prepatation",
                ),
                const Tab(
                  text: "Feedback",
                ),
              ],
            ),
          );
        },
      );
    }

    void showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext ctx) {
            return BlocBuilder<MealCubit, MealState>(
              builder: (context, state) {
                var cubit = MealCubit.get(context);
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
              },
            );
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
            return BlocBuilder<FeedbackCubit, FeedbackState>(
              builder: (context, state) {
                var cub = FeedbackCubit.get(context);
                TextEditingController descriptionController =
                    TextEditingController();
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
                              userdata.displayName ?? "Unknown",
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
                      // Row(
                      //   children: [
                      //     Container(
                      //       width: 120.w,
                      //       height: 27.h,
                      //       decoration: BoxDecoration(
                      //         color: g,
                      //         borderRadius: BorderRadius.circular(6).w,
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //         children: [
                      //           Text(
                      //             'Category : ',
                      //             style: TextStyle(
                      //                 color: b,
                      //                 fontWeight: FontWeight.w500,
                      //                 fontSize: 10.sp),
                      //           ),
                      //           DropdownButton(
                      //               iconEnabledColor: y,
                      //               value: cub.curricepFeedback,
                      //               items: li
                      //                   .map((e) => DropdownMenuItem(
                      //                         value: e,
                      //                         onTap: () {
                      //                           cub.changeFeedbackCategory(e);
                      //                         },
                      //                         child: Text(
                      //                           e,
                      //                           style: TextStyle(
                      //                               fontSize: 10.sp, color: b),
                      //                         ),
                      //                       ))
                      //                   .toList(),
                      //               onChanged: (val) {
                      //                 cub.changeFeedbackCategory(val!);
                      //               }),
                      //         ],
                      //       ),
                      //     ),
                      //     Container(
                      //       margin: const EdgeInsets.only(left: 11).w,
                      //       width: 215.w,
                      //       height: 27.h,
                      //       decoration: BoxDecoration(
                      //         color: g,
                      //         borderRadius: BorderRadius.circular(6).w,
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //         children: [
                      //           Text(
                      //             'Recipe name : ',
                      //             style: TextStyle(
                      //                 color: b,
                      //                 fontWeight: FontWeight.w500,
                      //                 fontSize: 10.sp),
                      //           ),
                      //           DropdownButton(
                      //               iconEnabledColor: y,
                      //               value: cub.ricepfeedback,
                      //               items: cub.currRicepFeedbackList
                      //                   .map((e) => DropdownMenuItem(
                      //                         value: e,
                      //                         child: Text(
                      //                           e,
                      //                           style: TextStyle(
                      //                               fontSize: 10.sp, color: b),
                      //                         ),
                      //                       ))
                      //                   .toList(),
                      //               onChanged: (val) {
                      //                 cub.recipe(val!);
                      //               }),
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),

                      Container(
                        width: 190.w,
                        margin: const EdgeInsets.only(top: 11, bottom: 4),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add photo',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Add Opinion',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w500),
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
                              if (state is LoadingMealState) {
                              } else {
                                if (str == '') {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                        title: Text("There are an error"),
                                        icon: Icon(Icons.error),
                                        content:
                                            Text("you have to add an image"),
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
                                          content: Text("select Recipe name"),
                                        );
                                      },
                                    );
                                  } else {
                                    await cub.publishFeedback(
                                        id: id,
                                        mealId: mealId,
                                        descreption1:
                                            descriptionController.text);
                                    Navigator.of(context).pop();
                                  }
                                }
                              }
                            },
                            child: (cub.publishprosses)
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

    return BlocBuilder<MealDetialCubit, MealDetialState>(
      builder: (context, state) {
        var cubit = MealDetialCubit.get(context);

        return Scaffold(
          floatingActionButton: BlocBuilder<FeedbackCubit, FeedbackState>(
            builder: (context, state) {
              var cubit = FeedbackCubit.get(context);
              return FloatingActionButton(
                backgroundColor: y,
                onPressed: () {
                  sheet(context, userdata.accessToken ?? "",
                      cubit.feedbackMealId ?? "");
                },
                child: Image(
                    height: 30.h, image: AssetImage('assest/message.png')),
              );
            },
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 2),
                        blurRadius: 12,
                      )
                    ]),
                child: Stack(
                  // alignment: const Alignment(1, 2),
                  children: [
                    Image(
                      height: 250.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage(meal.src ?? ""),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 10, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              cubit.ChangePageIndex(0);
                            },
                            child: const CircleAvatar(
                                backgroundColor: Color(0xFFEFF0F2),
                                child: Icon(Icons.arrow_back,
                                    color: Color(black))),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (!cubit.addfavoritemealprocces) {
                                      await cubit.addfavoriteMeal(meal, context,
                                          userMealfavorite: cubit.userMeal);
                                    }
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Color(white),
                                      child: Icon(
                                        (cubit.userMeal)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Color(orange),
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meal.title ?? "title",
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  shadows: [
                                    Shadow(
                                        blurRadius: 5,
                                        color:
                                            Color.fromARGB(255, 96, 114, 124),
                                        offset: Offset(3, 2))
                                  ],
                                ),
                              ),
                              StarRating(
                                starSize: 30.w,
                                color: const Color(orange),
                                length: 5,
                                rating: meal.rate ?? 0,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.timelapse,
                                color: Colors.orange,
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 3.h),
                                child: Text(meal.time ?? ""),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.star_border_outlined,
                                color: Colors.orange,
                              ),
                              Container(
                                  padding: EdgeInsets.only(bottom: 3.h),
                                  child: Text('${meal.rate!.round()}')),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      // height: 20.h,
                      width: double.infinity,
                      child: Text(
                        meal.descreption ?? 'nothing',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black26),
                      ),
                    ),
                    TabBarWidget(),
                    cubit.pageIndex == 0
                        ? IngredientScreen(
                            meal: meal,
                          )
                        : cubit.pageIndex == 1
                            ? PreparationScreen(meal: meal)
                            : FeedbackScreen(),
                  ],
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}
