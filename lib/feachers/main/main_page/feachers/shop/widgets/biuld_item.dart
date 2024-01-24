import 'package:DISH_DELIGhTS/core/userdata.dart';
import 'package:DISH_DELIGhTS/feachers/main/main_page/feachers/shop/cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/models/needs_model.dart';

class BuildItem extends StatelessWidget {
  const BuildItem(this.dish, this.index, {super.key});
  final Needs_Meal dish;
  final int index;
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return Dismissible(
          onDismissed: (direction) async {
            myshopList.removeAt(index);
            if (!cubit.removeneedsprocces) {
              await cubit.removeNeeds(dish,context);
            }
          },
          key: Key(dish.name),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dish.name,
                          style: TextStyle(
                              fontSize: 20.w, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '${dish.need}',
                            style: TextStyle(
                              fontSize: 20.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

