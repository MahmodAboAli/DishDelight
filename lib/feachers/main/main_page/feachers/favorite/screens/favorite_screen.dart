import 'package:DISH_DELIGhTS/core/userdata.dart';
import 'package:DISH_DELIGhTS/feachers/main/main_page/feachers/favorite/widgets/build_favorite_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color y = const Color.fromRGBO(255, 183, 77, 1);
    Color b = const Color.fromRGBO(55, 71, 79, 1);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50.h, bottom: 20.h, left: 10.w),
            width: double.infinity,
            color: y,
            child: Text(
              'My favorite meals',
              style: TextStyle(
                  color: b,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  shadows: const [
                    Shadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4.0,
                    )
                  ]),
            ),
          ),
          favoriteMeals.isEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 300.h),
                  child: const Text("There aren't any favorite meal"))
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 21),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.0411,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: favoriteMeals.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BuildFavoriteItem(
                            rate: favoriteMeals[index].rate ?? 0,
                            meal: favoriteMeals[index],
                            image: favoriteMeals[index].src ?? '',
                            name: favoriteMeals[index].title ?? 'title',
                            time: favoriteMeals[index].time ?? "15");
                      },
                    ),
                    //  GridView(
                    //   semanticChildCount: 2,
                    //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    //       maxCrossAxisExtent: 300,
                    //       childAspectRatio: 1.0411,
                    //       crossAxisSpacing: 20,
                    //       mainAxisSpacing: 20
                    //       ),
                    //   children: [
                    //     Unite(),

                    //   ],
                    // ),
                  ),
                ),
        ],
      ),
    );
  }
}
