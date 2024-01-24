import 'package:DISH_DELIGhTS/core/colors.dart';
import 'package:DISH_DELIGhTS/core/userdata.dart';
import 'package:DISH_DELIGhTS/feachers/main/main_page/feachers/shop/widgets/biuld_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopingList extends StatefulWidget {
  const ShopingList({Key? key}) : super(key: key);

  @override
  State<ShopingList> createState() => _ShopingListState();
}

class _ShopingListState extends State<ShopingList> {
  @override
  Widget build(BuildContext context) {
    Color y = Color.fromARGB(255, 255, 183, 77);

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50.h, bottom: 20.h, left: 10.w),
            width: double.infinity,
            color: y,
            child: const Text(
              'Shoping List',
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
          myshopList.isEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 300.h),
                  child: const Text("There aren't any needs"))
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          BuildItem(myshopList[index], index),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10.h,
                      ),
                      itemCount: myshopList.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
