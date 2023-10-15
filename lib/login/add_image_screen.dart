import 'dart:async';

import 'package:DISH_DELIGhTS/cubit/meal_cubit.dart';
import 'package:DISH_DELIGhTS/login/save_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../core/colors.dart';
import 'cubit/login_cubit.dart';
// ignore: must_be_immutable

final formkey = GlobalKey<FormState>();

class AddImageScreen extends StatelessWidget {
  AddImageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var sizehight = MediaQuery.of(context).size.height / 852;
    var sizeWidth = MediaQuery.of(context).size.width / 393;
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {},
      builder: (context, state) {
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
          // Navigator.of(context).pop();
        }

        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: sizehight * 69,
              ),
              Image.asset(
                'assest/logo.png',
                fit: BoxFit.cover,
                height: sizehight * 165,
                width: sizeWidth * 190,
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add a profile picture to complete your account',
                      style: TextStyle(
                        color: Color(black),
                      ),
                    ),
                    SizedBox(
                      height: 130.h,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          showPicker(context);
                        },
                        child: CircleAvatar(
                            backgroundColor: const Color(lightGrey),
                            radius: 60.w,
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: Color(black),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 120.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50.h,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          if (cubit.str != '') {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => SaveDataScreen(),
                            ));
                          }
                        },
                        child: cubit.addphotoprocces
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : const Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
