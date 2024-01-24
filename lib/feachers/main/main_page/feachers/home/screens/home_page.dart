import 'dart:math';

import 'package:DISH_DELIGhTS/cubit/meal_cubit.dart';
import 'package:DISH_DELIGhTS/feachers/main/main_page/feachers/home/widgets/end_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import '../../../../../../core/userdata.dart';
import '../../../../meal_detial_page/models/meal_detial_model.dart';
import '../../../../meal_detial_page/screens/meal_detia_screenl.dart';
import '../cubit/home_cubit.dart';
import 'catagory_page.dart';

class HomePage extends StatelessWidget {
  final controller =
      PageController(initialPage: 0, viewportFraction: 1, keepPage: true);

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Color y = const Color.fromRGBO(255, 183, 77, 1);
    Color b = const Color.fromRGBO(55, 71, 79, 1);
    Color w = const Color.fromRGBO(252, 252, 252, 1);

    List<MealDetial> a = bestMeals.isEmpty ? Meals : bestMeals;
    List<MealDetial> mMeals = currMeal;
    return Scaffold(
      endDrawer: EndDrawer(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    height: 400.h,
                    width: 393.w,
                    decoration: BoxDecoration(
                        color: y,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 6, // soften the shadow
                            spreadRadius: 0, //extend the shadow
                            offset: Offset(
                              0, // Move to right 5  horizontally
                              4.0, // Move to bottom 5 Vertically
                            ),
                          )
                        ],
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30).w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0).h,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        blurRadius: 4, // soften the shadow
                                        spreadRadius: 0, //extend the shadow
                                        offset: Offset(
                                          1, // Move to right 5  horizontally
                                          2, // Move to bottom 5 Vertically
                                        ),
                                      )
                                    ]),
                                width: 251.w,
                                height: 45.h,
                                padding: EdgeInsets.only(bottom: 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      fillColor: w,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(239, 240, 242, 1),
                                        ),
                                        borderRadius: BorderRadius.circular(80),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2),
                                        borderRadius: BorderRadius.circular(80),
                                      ),
                                      prefixIcon: const Icon(Icons.search),
                                      hintText: 'Search recipes',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey)),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(left: 17).w,
                                  width: 35.w,
                                  height: 35.h,
                                  child: BlocBuilder<MealCubit, MealState>(
                                    builder: (context, state) {
                                      var cubit = MealCubit.get(context);
                                      return FloatingActionButton(
                                          heroTag: const Text('1'),
                                          backgroundColor: w,
                                          foregroundColor: b,
                                          child: const Icon(
                                            Icons.filter_alt_outlined,
                                          ),
                                          onPressed: () {
                                            // cubit.getData();
                                            cubit.filterMeals();
                                          });
                                    },
                                  )),
                              Builder(builder: (context) {
                                return Container(
                                    margin: const EdgeInsets.only(left: 13),
                                    width: 35.w,
                                    height: 35.h,
                                    child: FloatingActionButton(
                                        heroTag: const Text('2'),
                                        backgroundColor: w,
                                        foregroundColor: b,
                                        child: const Icon(Icons.menu),
                                        onPressed: () async {
                                          Scaffold.of(context).openEndDrawer();
                                        }));
                              }),
                            ],
                          ),
                        ),
                        Container(
                          width: 163.w,
                          height: 34.h,
                          margin: const EdgeInsets.only(
                            top: 16,
                            left: 5,
                          ).w,
                          child: Text(
                            'Trendy Today',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                shadows: const [
                                  Shadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.06),
                                    offset: Offset(0, 4),
                                    blurRadius: 4.0,
                                  )
                                ],
                                color: b,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          width: 333.w,
                          margin: const EdgeInsets.only(top: 8).w,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              BlocBuilder<HomeCubit, HomeState>(
                                builder: (context, state) {
                                  var cubit = HomeCubit.get(context);
                                  return CarouselSlider(
                                    options: CarouselOptions(
                                        height: 200.0.h,
                                        initialPage: 0,
                                        viewportFraction: 1.5,
                                        onPageChanged: (val,
                                            CarouselPageChangedReason reason) {
                                          cubit.homechangeindicator(val);
                                        }),
                                    items: a.map((i) {
                                      return BlocBuilder<HomeCubit, HomeState>(
                                        builder: (context, state) {
                                          log(999);
                                          print(i.src);
                                          var cubit = HomeCubit.get(context);
                                          return GestureDetector(
                                            onTap: () async {
                                              await cubit.initneeds(i);
                                              await cubit
                                                  .getuserMeal(i.title ?? "");
                                              await cubit.getMealFeedbacks(
                                                  id: i.title ?? "");
                                              await cubit.getMealDetial(
                                                  id: i.title ?? "");
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    MealDetialScreen(meal: i),
                                              ));
                                            },
                                            child: SizedBox(
                                              width: 333.w,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.w),
                                                child: Image.network(
                                                  i.src ?? "",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                              BlocBuilder<HomeCubit, HomeState>(
                                builder: (context, state) {
                                  var cubit = HomeCubit.get(context);
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 8.w),
                                    child: PageViewDotIndicator(
                                      currentItem: cubit.page,
                                      count: 3,
                                      unselectedColor: const Color.fromRGBO(
                                          217, 217, 217, 1),
                                      selectedColor: y,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      boxShape: BoxShape.circle,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: 133.w,
                height: 34.h,
                margin: const EdgeInsets.only(top: 36, left: 28, bottom: 8).w,
                child: Text(
                  'Categories',
                  style: TextStyle(shadows: const [
                    Shadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(0, 3),
                      blurRadius: 3.0,
                    )
                  ], color: b, fontSize: 24.sp, fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 11, left: 10, right: 10).h,
                height: 40.h,
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    var cubit = HomeCubit.get(context);
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30).w,
                              child: InkWell(
                                child: Container(
                                  // width: 80.w,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: cubit.selectMain == true ? y : w,
                                    borderRadius: BorderRadius.circular(10).w,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Main',
                                      style: TextStyle(
                                          color:
                                              cubit.selectMain == true ? w : b,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  cubit.changeListofMeal(1);
                                  cubit.homeActive_Catagory(1);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: GestureDetector(
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: cubit.selectAprrtie == true ? y : w,
                                    borderRadius: BorderRadius.circular(10).w,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Appitizers',
                                      style: TextStyle(
                                          color: cubit.selectAprrtie == true
                                              ? w
                                              : b,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  cubit.changeListofMeal(2);
                                  cubit.homeActive_Catagory(2);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12).w,
                              child: GestureDetector(
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: cubit.selectSweet == true ? y : w,
                                    borderRadius: BorderRadius.circular(10).w,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sweets',
                                      style: TextStyle(
                                          color:
                                              cubit.selectSweet == true ? w : b,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  cubit.changeListofMeal(3);
                                  cubit.homeActive_Catagory(3);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: GestureDetector(
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: cubit.selectDrink == true ? y : w,
                                    borderRadius: BorderRadius.circular(10).w,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Drinks',
                                      style: TextStyle(
                                          color:
                                              cubit.selectDrink == true ? w : b,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  cubit.changeListofMeal(4);
                                  cubit.homeActive_Catagory(4);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: GestureDetector(
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: cubit.selectCandie == true ? y : w,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Candies',
                                      style: TextStyle(
                                          color: cubit.selectCandie == true
                                              ? w
                                              : b,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  cubit.changeListofMeal(5);
                                  cubit.homeActive_Catagory(5);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: GestureDetector(
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: cubit.selectVegin == true ? y : w,
                                    borderRadius: BorderRadius.circular(10).w,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Diet',
                                      style: TextStyle(
                                          color:
                                              cubit.selectVegin == true ? w : b,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  cubit.changeListofMeal(6);
                                  cubit.homeActive_Catagory(6);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                      scrollDirection: Axis.horizontal,
                    );
                  },
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  margin: EdgeInsets.only(left: 30.w, top: 12.h),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return CatagoryPage();
                        }));
                      },
                      child: Container(
                        child: Text(
                          'See all',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ))),
              SizedBox(
                height: 200.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: mMeals
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 180,
                              height: 160.h,
                              decoration: BoxDecoration(
                                  color: w,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(255, 255, 255, 0.3),
                                      blurRadius: 7,
                                      spreadRadius: 0,
                                      offset: Offset(-3, -3),
                                    ),
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.2),
                                      blurRadius: 8,
                                      spreadRadius: 0,
                                      offset: Offset(1, 3),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(16)),
                              child: BlocBuilder<HomeCubit, HomeState>(
                                builder: (context, state) {
                                  var cubit = HomeCubit.get(context);
                                  return InkWell(
                                    onTap: () async {
                                      await cubit.getMealDetial(
                                          id: e.title ?? "");
                                      await cubit.initneeds(e);
                                      await cubit.getuserMeal(e.title ?? "");
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            MealDetialScreen(meal: e),
                                      ));
                                      await cubit.getMealFeedbacks(
                                          id: e.title ?? "");
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 90.h,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                e.src ?? '',
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.title ?? "title",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.watch_later_outlined,
                                                    size: 18,
                                                    color: y,
                                                  ),
                                                  Text(
                                                    e.time ?? "time",
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          127, 127, 127, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              // const Spacer(),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star_border,
                                                    color: y,
                                                    size: 18,
                                                  ),
                                                  Text(
                                                    "${e.rate!.round()}",
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          127, 127, 127, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
