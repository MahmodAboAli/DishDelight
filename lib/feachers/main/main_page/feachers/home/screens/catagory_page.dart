import 'package:DISH_DELIGhTS/core/userdata.dart';
import 'package:DISH_DELIGhTS/feachers/main/main_page/feachers/home/widgets/build_category_item.dart';
import 'package:flutter/material.dart';


class CatagoryPage extends StatelessWidget {
  const CatagoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color y = const Color.fromRGBO(255, 183, 77, 1);
    Color b = const Color.fromRGBO(55, 71, 79, 1);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
      appBar: AppBar(
        backgroundColor: y,
        title: Text(
          'All Catagories',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 21),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0411,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: currMeal.length,
          itemBuilder: (BuildContext context, int index) {
            return BuildCategoryItem(
                meal: currMeal[index],
                image: currMeal[index].src ?? '',
                rate: currMeal[index].rate ?? 0,
                name: currMeal[index].title ?? 'title',
                time: currMeal[index].time ?? "15");
          },
        ),
      ),
    );
  }
}
