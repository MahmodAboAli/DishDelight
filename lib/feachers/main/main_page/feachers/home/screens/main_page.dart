import 'package:DISH_DELIGhTS/core/userdata.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../add_meal_steps/screens/steps1.dart';
import '../../favorite/screens/favorite_screen.dart';
import '../../feedback/screens/feedback.dart';
import '../../shop/screens/shoping_list.dart';
import 'home_page.dart';

// ignore: must_be_immutable
class FirstPage extends StatelessWidget {
  Color y = const Color.fromRGBO(255, 183, 77, 1);
  Color b = const Color.fromRGBO(55, 71, 79, 1);
  Color w = const Color.fromRGBO(252, 252, 252, 1);

  FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavBar(
          actionButton: CurvedActionBar(
            onTab: (value) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Steps1(),
              ));
            },
            activeIcon: Container(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 7),
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              decoration: BoxDecoration(color: y, shape: BoxShape.circle),
              child: Icon(
                Icons.add,
                size: 50,
                color: b,
              ),
            ),
            inActiveIcon: Container(
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 7),
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              decoration: BoxDecoration(color: y, shape: BoxShape.circle),
              child: Icon(
                Icons.add,
                size: 50,
                color: b,
              ),
            ),
          ),
          activeColor: y,
          navBarBackgroundColor: w,
          inActiveColor: b,
          appBarItems: [
            FABBottomAppBarItem(
              activeIcon: Image(
                height: 30.w,
                image: AssetImage("assest/home2.png"),
              ),
              inActiveIcon: Image(
                height: 30.w,
                image: AssetImage("assest/home1.png"),
              ),
              text: '',
            ),
            FABBottomAppBarItem(
              activeIcon: Image(
                height: 30.w,
                image: AssetImage("assest/heart2.png"),
              ),
              inActiveIcon: Image(
                height: 30.w,
                image: AssetImage("assest/heart.png"),
              ),
              text: '',
            ),
            FABBottomAppBarItem(
              activeIcon: myshopList.isEmpty
                  ? Image(
                      height: 30.w,
                      image: AssetImage("assest/shopping-cart.png"),
                    )
                  : Stack(
                      alignment: const Alignment(2, -1.5),
                      children: [
                        Image(
                          height: 30.w,
                          image: AssetImage("assest/shopping-cart.png"),
                        ),
                        myshopList.isEmpty
                            ? Container()
                            : Container(
                                width: 17.w,
                                height: 17.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.w),
                                  color: Colors.red,
                                ),
                                child: Center(
                                    child: Text(myshopList.length.toString())),
                              )
                      ],
                    ),
              inActiveIcon: myshopList.isEmpty
                  ? Image(
                      height: 30.w,
                      image: AssetImage("assest/shopping-cart1.png"),
                    )
                  : Stack(
                      alignment: const Alignment(2, -1.5),
                      children: [
                        Image(
                          height: 30.w,
                          image: AssetImage("assest/shopping-cart1.png"),
                        ),
                        myshopList.isEmpty
                            ? Container()
                            : Container(
                                width: 17.w,
                                height: 17.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.w),
                                  color: Colors.red,
                                ),
                                child: Center(
                                    child: Text(myshopList.length.toString())),
                              )
                      ],
                    ),
              text: '',
            ),
            FABBottomAppBarItem(
              activeIcon: Image(
                height: 30.w,
                image: AssetImage("assest/card2.png"),
              ),
              inActiveIcon: Image(
                height: 30.w,
                image: AssetImage("assest/card.png"),
              ),
              text: '',
            ),
          ],
          bodyItems: [
            HomePage(),
            FavoriteScreen(),
            ShopingList(),
            Feed_Back(),
          ]),
    );
  }
}
