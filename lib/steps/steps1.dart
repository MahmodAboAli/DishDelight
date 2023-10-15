// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:DISH_DELIGhTS/steps/steps2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../core/colors.dart';
import '../cubit/meal_cubit.dart';

class Steps1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = MealCubit.get(context);
    void showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext ctx) {
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
          });
    }

    TextEditingController recipeController = cubit.recipeController;
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        String Category = cubit.catigoryName;
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text(
                "Recipe",
                style: TextStyle(color: Color(0xFF1D405B)),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color(orange),
                              child: Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(white),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(Grey),
                                ),
                                width: 108.w,
                                height: 7.h,
                              ),
                            ),
                            const CircleAvatar(
                              backgroundColor: Color(Grey),
                              child: Text(
                                "2",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(white),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(Grey),
                                ),
                                width: 108.w,
                                height: 7,
                              ),
                            ),
                            const CircleAvatar(
                              backgroundColor: Color(Grey),
                              child: Text(
                                "3",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(white),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 25.h,
                      ),

                      const Text(
                        "Recipe Name:",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF37474F)),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextField(
                        onChanged: (value) {
                          cubit.changeRecipe(value);
                        },
                        controller: recipeController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: const Color(lightGrey),
                          hintText: 'type name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Text(
                        "Category:",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF37474F)),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: const Color(lightGrey),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton(
                          onChanged: (value) {
                            cubit.changeCategory(value!);
                          },
                          value: Category,
                          hint: const Text("Choose category"),
                          items: [
                            DropdownMenuItem(
                              value: "Main",
                              child: const Text('Main'),
                              onTap: () {
                                cubit.changeCatigoryName("Main");
                                // Category = 'Main';
                              },
                            ),
                            DropdownMenuItem(
                              value: "Sweetes",
                              child: const Text('Sweetes'),
                              onTap: () {
                                cubit.changeCatigoryName("Sweetes");
                                // Category = 'Sweetes';
                              },
                            ),
                            DropdownMenuItem(
                              value: "Aprrtie",
                              child: const Text("Aprrtie"),
                              onTap: () {
                                cubit.changeCatigoryName("Aprrtie");
                                // Category = 'Aprrtie';
                              },
                            ),
                            DropdownMenuItem(
                              value: "Drinks",
                              child: const Text("Drinks"),
                              onTap: () {
                                cubit.changeCatigoryName("Drinks");
                                // Category = 'Drinks';
                              },
                            ),
                            DropdownMenuItem(
                              value: "Candies",
                              child: const Text("Candies"),
                              onTap: () {
                                cubit.changeCatigoryName("Candies");
                                // Category = 'Candies';
                              },
                            ),
                            DropdownMenuItem(
                              value: "Vegin",
                              child: const Text("Vegin"),
                              onTap: () {
                                cubit.changeCatigoryName("Vegin");
                                // Category = 'Vegin';
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Text(
                        "Add picture:",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF37474F)),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            showPicker(context);
                            // Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFDBDBDB),
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 135.h,
                            width: 305.w,
                            child: const Center(
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   height: 100,
                      //   child: SingleChildScrollView(
                      //     child: TextField(
                      //         maxLines: 5, keyboardType: TextInputType.multiline),
                      //   ),
                      // ),
                      // const Spacer(),
                      SizedBox(
                        height: 150.h,
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF37474F),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            await cubit.findMeal(
                                tit: cubit.recipeController.text);
                            if (cubit.foundMeal) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    title: Text("There are an error"),
                                    icon: Icon(Icons.error),
                                    content: Text("The name is already used"),
                                  );
                                },
                              );
                            } else {
                              if (cubit.str == '') {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: Text("There are an error"),
                                      icon: Icon(Icons.error),
                                      content: Text("you have to add an image"),
                                    );
                                  },
                                );
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Steps2(),
                                ));
                              }
                            }
                          },
                          child: const Text(
                            'Next ',
                            style: TextStyle(
                                color: Color(0XFFFFFFFF),
                                fontSize: 20,
                                fontFamily: 'Tajawal'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ]),
              ),
            ));
      },
    );
  }
}
