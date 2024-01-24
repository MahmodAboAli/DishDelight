import 'package:DISH_DELIGhTS/feachers/Auth/cubit/login_cubit.dart';
import 'package:DISH_DELIGhTS/feachers/main/main_page/feachers/home/screens/main_page.dart';
import 'package:DISH_DELIGhTS/feachers/Auth/screens/Sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors.dart';

// ignore: must_be_immutable

final formkey = GlobalKey<FormState>();

class SaveDataScreen extends StatelessWidget {
  SaveDataScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var sizehight = MediaQuery.of(context).size.height / 852;
    var sizeWidth = MediaQuery.of(context).size.width / 393;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
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
                      child: Container(
                        height: 100.h,
                        width: 100.h,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              cubit.str,
                              fit: BoxFit.fill,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 130.h,
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
                          await cubit.authenticate(
                              context: context,
                              email: cubit.userEmail.text,
                              password: cubit.userPassword.text,
                              create: true,
                              save: true,
                              displayName:
                                  '${cubit.userName.text} ${cubit.lastUserName.text}');
                          print('done Auth');
                          if (cubit.doneLogin) {
                            await cubit.printprofile();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => FirstPage(),
                                ),
                                (route) => false);
                          } else {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                                (route) => false);
                          }
                        },
                        child: const Text(
                          'Save',
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
