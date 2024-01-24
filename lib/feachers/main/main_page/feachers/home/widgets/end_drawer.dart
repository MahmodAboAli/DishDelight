import 'package:DISH_DELIGhTS/core/userdata.dart';
import 'package:DISH_DELIGhTS/cubit/meal_cubit.dart';
import 'package:DISH_DELIGhTS/feachers/Auth/screens/Sign_up.dart';
import 'package:DISH_DELIGhTS/feachers/main/main_page/feachers/home/cubit/home_cubit.dart';
import 'package:DISH_DELIGhTS/feachers/main/profile/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Color y = const Color.fromRGBO(255, 183, 77, 1);
    Color b = const Color.fromRGBO(55, 71, 79, 1);
    return Drawer(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: y,
              height: 200.h,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10).w,
                      child: ClipOval(
                        clipBehavior: Clip.antiAlias,
                        child: SizedBox(
                            width: 110.w,
                            height: 110.h,
                            child: Image.network(
                              userdata.photoUrl ?? "",
                              fit: BoxFit.fill,
                            )),
                      ),
                    ),
                    Text(
                      userdata.displayName ?? "Unknown",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: b),
                    ),
                    Text(
                      userdata.email ?? "there isn't",
                      style: TextStyle(
                        color: b,
                        fontSize: 12.sp,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10).w,
              height: 400.h,
              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10).w,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      var hcubit = HomeCubit.get(context);
                      return ListTile(
                        onTap: () async {
                          await hcubit.getMyMeal();
                          await hcubit.getMyFeedbacks(
                              id: userdata.accessToken ?? "");
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return ProfilePage();
                          }));
                        },
                        title: Text(
                          'My Profile',
                          style: TextStyle(fontSize: 20.sp, color: b),
                        ),
                        leading: Icon(
                          Icons.person,
                          color: y,
                          size: 25,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      'Notification',
                      style: TextStyle(fontSize: 20, color: b),
                    ),
                    leading: Icon(
                      Icons.notifications,
                      color: y,
                      size: 25,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      'Privacy',
                      style: TextStyle(fontSize: 20, color: b),
                    ),
                    leading: Icon(
                      Icons.info,
                      color: y,
                      size: 25,
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          icon: Icon(Icons.error),
                          title: const Text('Are you sure?'),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BlocBuilder<MealCubit, MealState>(
                                builder: (context, state) {
                                  var cubit = MealCubit.get(context);
                                  return TextButton(
                                    child: const Text("Log out"),
                                    onPressed: () async {
                                      await cubit.onlogout();
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => SignUp(),
                                          ),
                                          (route) => false);
                                    },
                                  );
                                },
                              ),
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    title: Text(
                      'LogOut',
                      style: TextStyle(fontSize: 20, color: b),
                    ),
                    leading: IconButton(
                      onPressed: () async {},
                      icon: Icon(
                        Icons.logout,
                        color: y,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
