import 'package:DISH_DELIGhTS/login/Sign_up.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/meal_cubit.dart';
import '../../meal_detial/meal_detia_screenl.dart';
import '../../model/meal_detial.dart';
import '../Profile/profile.dart';

class HomePage extends StatelessWidget {
  final controller =
      PageController(initialPage: 0, viewportFraction: 1, keepPage: true);

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Color y = const Color.fromRGBO(255, 183, 77, 1);
    Color b = const Color.fromRGBO(55, 71, 79, 1);
    Color w = const Color.fromRGBO(252, 252, 252, 1);
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealCubit.get(context);
        // cubit.printprofile();
        List<MealDetial> a =
            cubit.BestMeal.isEmpty ? cubit.Meals : cubit.BestMeal;
        List<MealDetial> mMeals = cubit.currMeal;
        return Scaffold(
          endDrawer: Drawer(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20).w,
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
                                    cubit.userdata.photoUrl ?? "",
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          ),
                          Text(
                            cubit.userdata.displayName ?? "Unknown",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: b),
                          ),
                          Text(
                            cubit.userdata.email ?? "there isn't",
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 13, vertical: 10).w,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        ListTile(
                          onTap: () async {
                            await cubit.getMyMeal();
                            await cubit.getMyFeedbacks(
                                id: cubit.userdata.accessToken ?? "");
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      child: const Text("Log out"),
                                      onPressed: () async {
                                        await cubit.onlogout();
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUp(),
                                                ),
                                                (route) => false);
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
          ),
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
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.25),
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
                                              color: Color.fromRGBO(
                                                  239, 240, 242, 1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(80),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(80),
                                          ),
                                          prefixIcon: const Icon(Icons.search),
                                          hintText: 'Search recipes',
                                          hintStyle: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(left: 17).w,
                                      width: 35.w,
                                      height: 35.h,
                                      child: FloatingActionButton(
                                          heroTag: const Text('1'),
                                          backgroundColor: w,
                                          foregroundColor: b,
                                          child: const Icon(
                                            Icons.filter_alt_outlined,
                                          ),
                                          onPressed: () {})),
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
                                              // await cubit.printprofile();
                                              cubit.openDrawer(context);
                                              // Scaffold.of(context).openDrawer;
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
                                  CarouselSlider(
                                    options: CarouselOptions(
                                        height: 200.0.h,
                                        initialPage: 0,
                                        viewportFraction: 1.5,
                                        onPageChanged: (val,
                                            CarouselPageChangedReason reason) {
                                          cubit.homechangeindicator(val);
                                        }),
                                    items: a.map((i) {
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
                                    }).toList(),
                                  ),

                                  // SmoothPageIndicator(
                                  //     controller:
                                  //         pageController, // PageController
                                  //     count: 3,
                                  //     effect: CustomizableEffect(
                                  //         dotDecoration: DotDecoration(
                                  //           borderRadius:
                                  //               BorderRadius.circular(5),
                                  //           width: 16,
                                  //           height: 3,
                                  //         ),
                                  //         activeDotDecoration: DotDecoration(
                                  //           borderRadius:
                                  //               BorderRadius.circular(5),
                                  //           width: 16,
                                  //           height: 3,
                                  //           color: const Color(0xFFE88500),
                                  //         )), // your preferred effect
                                  //     onDotClicked: (index) {}),
                                  Container(
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
                    margin:
                        const EdgeInsets.only(top: 36, left: 28, bottom: 8).w,
                    child: Text(
                      'Categories',
                      style: TextStyle(
                          shadows: const [
                            Shadow(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              offset: Offset(0, 3),
                              blurRadius: 3.0,
                            )
                          ],
                          color: b,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 11, left: 10, right: 10).h,
                    height: 40.h,
                    child: ListView.builder(
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
                                    color: cubit.a == true ? y : w,
                                    borderRadius: BorderRadius.circular(10).w,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Main',
                                      style: TextStyle(
                                          color: cubit.a == true ? w : b,
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
                                    color: cubit.b1 == true ? y : w,
                                    borderRadius: BorderRadius.circular(10).w,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Appitizers',
                                      style: TextStyle(
                                          color: cubit.b1 == true ? w : b,
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
                                    color: cubit.c == true ? y : w,
                                    borderRadius: BorderRadius.circular(10).w,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sweets',
                                      style: TextStyle(
                                          color: cubit.c == true ? w : b,
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
                                    color: cubit.d == true ? y : w,
                                    borderRadius: BorderRadius.circular(10).w,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Drinks',
                                      style: TextStyle(
                                          color: cubit.d == true ? w : b,
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
                                    color: cubit.e == true ? y : w,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Candies',
                                      style: TextStyle(
                                          color: cubit.e == true ? w : b,
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
                                    color: cubit.f == true ? y : w,
                                    borderRadius: BorderRadius.circular(10).w,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Diet',
                                      style: TextStyle(
                                          color: cubit.f == true ? w : b,
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
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      margin: EdgeInsets.only(left: 30.w, top: 12.h),
                      child: GestureDetector(
                          onTap: () {
                            cubit.hometocate(context);
                          },
                          child: Container(
                            child: Text(
                              'See all',
                              style: TextStyle(color: Colors.grey),
                            ),
                            // child:
                            // Image(image: AssetImage('assest/Vector.svg')),
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
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.3),
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
                                  child: InkWell(
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
      },
    );
  }
}
