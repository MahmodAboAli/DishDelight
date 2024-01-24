// ignore_for_file: must_be_immutable

import 'package:DISH_DELIGhTS/feachers/main/profile/widgets/pro_cecipe.dart';
import 'package:DISH_DELIGhTS/feachers/main/profile/widgets/pro_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/pro_cubit.dart';
import 'editprofile.dart';
import '../../../../core/userdata.dart';

class ProfilePage extends StatelessWidget {
  Color y = const Color.fromRGBO(255, 183, 77, 1);

  Color b = const Color.fromRGBO(55, 71, 79, 1);

  Color w = const Color.fromRGBO(252, 252, 252, 1);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProCubit, ProState>(
      builder: (context, state) {
        var cubit = ProCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
                cubit.changeTabProIndex(0);
              },
            ),
            title: Text(
              'My Profile',
              style: TextStyle(color: b, shadows: const [
                Shadow(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ]),
            ),
            backgroundColor: y,
            elevation: 0,
          ),
          body: DefaultTabController(
            length: 2,
            child: SizedBox(
              width: 393.w,
              child: Column(
                children: [
                  Container(
                    color: y,
                    height: 35,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        // height: 237.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: w,
                            borderRadius: BorderRadius.circular(15).w,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  offset: Offset(1, 3),
                                  blurRadius: 6,
                                  spreadRadius: 0)
                            ]),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditProfile(),
                                ));
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit_outlined,
                                    color: y,
                                    size: 15,
                                  ),
                                  Text(
                                    '  Edit',
                                    style: TextStyle(color: y, fontSize: 16.w),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 11.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userdata.displayName ?? '',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: b),
                                )
                              ],
                            ),
                          ),
                          Container(
                            // height: 55.h,
                            padding: EdgeInsets.symmetric(horizontal: 78.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(),
                                    Text(
                                    myMeal.length.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(164, 164, 164, 1),
                                      ),
                                    ),
                                    Text(
                                      'Recipe',
                                      style: TextStyle(fontSize: 10, color: y),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: const Color.fromRGBO(217, 217, 217, 1),
                                  height: 42.h,
                                  width: 2.w,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(),
                                    Text(
                                      favoriteMeals.length.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(164, 164, 164, 1),
                                      ),
                                    ),
                                    Text(
                                      'Favorite',
                                      style: TextStyle(fontSize: 10, color: y),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: const Color.fromRGBO(217, 217, 217, 1),
                                  height: 42.h,
                                  width: 2.w,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      myFeedbacks.length.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(164, 164, 164, 1),
                                      ),
                                    ),
                                    Text(
                                      'Feedback',
                                      style: TextStyle(fontSize: 10, color: y),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 1),
                            child: Divider(
                              height: 1,
                              color: Color.fromRGBO(213, 213, 213, 1),
                            ),
                          ),
                          TabBar(
                            labelColor: b,
                            onTap: (value) {
                              cubit.changeTabProIndex(value);
                            },
                            indicatorColor: Colors.white.withOpacity(1),
                            tabs: <Widget>[
                              Tab(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color: cubit.tabIndex == 0
                                        ? Color(0xFFFFB74D)
                                        : Colors.white,
                                    boxShadow: [
                                      cubit.tabIndex == 0
                                          ? BoxShadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(.25),
                                              offset: Offset(1, 3),
                                              blurRadius: 3)
                                          : BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(1, 3),
                                              blurRadius: 8)
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Recipe',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: cubit.tabIndex == 0
                                            ? Colors.white
                                            : Color(0xFF7F7F7F)),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      cubit.tabIndex == 1
                                          ? BoxShadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(.25),
                                              offset: Offset(1, 3),
                                              blurRadius: 3)
                                          : BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(1, 3),
                                              blurRadius: 8)
                                    ],
                                    color: cubit.tabIndex == 1
                                        ? Color(0xFFFFB74D)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Feedback',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: cubit.tabIndex == 1
                                            ? Colors.white
                                            : Color(0xFF7F7F7F)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                      Positioned(
                        top: -30.h,
                        right: 155.w,
                        child: ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child: SizedBox(
                              width: 90.w,
                              height: 90.h,
                              child: Image.network(
                                userdata.photoUrl ?? "",
                                fit: BoxFit.fill,
                              )),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  Expanded(
                    child: TabBarView(children: <Widget>[
                      ProRecipe(),
                      ProFeed(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
