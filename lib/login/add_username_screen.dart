import 'package:DISH_DELIGhTS/cubit/meal_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/colors.dart';
import 'add_image_screen.dart';
import 'cubit/login_cubit.dart';
// ignore: must_be_immutable

final formkey = GlobalKey<FormState>();

class AddUsernameScreen extends StatelessWidget {
  AddUsernameScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var sizehight = MediaQuery.of(context).size.height / 852;
    var sizeWidth = MediaQuery.of(context).size.width / 393;
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealCubit.get(context);

        TextEditingController userName = cubit.userName;
        TextEditingController lastUserName = cubit.lastUserName;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
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
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                  blurRadius: 3,
                                  color: Color(black),
                                  offset: Offset(1, 1))
                            ],
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Create an account in DISH_DELIGHT',
                        style: TextStyle(
                          color: Color(lightGrey),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Form(
                          key: formkey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  controller: userName,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.4),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Color(lightGrey),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  controller: lastUserName,
                                  onChanged: (value) {
                                    print(value);
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(lightGrey),
                                    labelText: 'Last Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 150.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () async {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => AddImageScreen(),
                            ));
                            // formkey.currentState!.validate();
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
