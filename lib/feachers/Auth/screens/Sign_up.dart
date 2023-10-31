// ignore_for_file: use_build_context_synchronously

import 'package:DISH_DELIGhTS/cubit/meal_cubit.dart';
import 'package:DISH_DELIGhTS/feachers/main/main_page/screens/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors.dart';
import 'add_username_screen.dart';

// ignore: must_be_immutable

final formkey = GlobalKey<FormState>();

class SignUp extends StatelessWidget {
  SignUp({super.key});
  @override
  Widget build(BuildContext context) {
    var sizehight = MediaQuery.of(context).size.height / 852;
    var sizeWidth = MediaQuery.of(context).size.width / 393;
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealCubit.get(context);

        TextEditingController userEmail = cubit.userEmail;
        TextEditingController userPassword = cubit.userPassword;
        TextEditingController userConfirm = cubit.userConfirm;
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
                        child: Text(
                          cubit.login ? 'Login' : 'Sign Up',
                          style: const TextStyle(
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
                      cubit.login
                          ? Text('')
                          : const Text(
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
                                height: 70,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains('@gmail.com')) {
                                      return 'input available Email';
                                    }
                                    return null;
                                  },
                                  controller: userEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.4),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Color(lightGrey),
                                    suffixIcon: Icon(Icons.email_outlined),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height: 70,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.length < 7) {
                                      return 'The lenght of Passsword less than 7';
                                    }
                                    return null;
                                  },
                                  controller: userPassword,
                                  onChanged: (value) {
                                    print(value);
                                  },
                                  obscureText: cubit.oboscurypass,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(lightGrey),
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(cubit.oboscurypass
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: cubit.obscurypassword,
                                    ),
                                  ),
                                ),
                              ),
                              cubit.login
                                  ? const SizedBox()
                                  : const SizedBox(
                                      height: 30,
                                    ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: cubit.login ? 0 : 70,
                                child: cubit.login
                                    ? Container()
                                    : TextFormField(
                                        validator: (value) {
                                          if (userConfirm.text !=
                                              userPassword.text) {
                                            return "Password isn't equal confige";
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          print(value);
                                        },
                                        controller: userConfirm,
                                        obscureText: cubit.oboscurycon,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(lightGrey),
                                          labelText: 'Confirm Password',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(cubit.oboscurycon
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                            onPressed: cubit.obscuryconfige,
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 50,
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
                            if (formkey.currentState!.validate()) {
                              if (cubit.login) {
                                await cubit
                                    .authenticate(
                                        context: context,
                                        email: userEmail.text,
                                        password: userPassword.text,
                                        create: false)
                                    .onError((error, stackTrace) => showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const AlertDialog(
                                              title: Text("There are an error"),
                                              icon: Icon(Icons.error),
                                              content: Text(
                                                  "correct the information"),
                                            );
                                          },
                                        ));
                                if (cubit.doneLogin) {
                                  await cubit.printprofile();
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => FirstPage(),
                                  ));
                                }
                              } else {
                                await cubit.fonduser(
                                    context: context,
                                    email: userEmail.text,
                                    password: userPassword.text,
                                    create: true);
                                if (!cubit.finduser) {
                                  await cubit
                                      .authenticate(
                                          context: context,
                                          email: userEmail.text,
                                          password: userPassword.text,
                                          create: true)
                                      .onError((error, stackTrace) =>
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "There are an error"),
                                                icon: Icon(Icons.error),
                                                content: Text(error.toString()),
                                              );
                                            },
                                          ));
                                  if (cubit.doneLogin) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => AddUsernameScreen(),
                                    ));
                                  }
                                }
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    title: Text("There are an error"),
                                    icon: Icon(Icons.error),
                                    content: Text("correct the information"),
                                  );
                                },
                              );
                            }
                          },
                          child: Text(
                            cubit.login ? 'Log In' : 'Sign UP',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      (state is loadingState)
                          ? const LinearProgressIndicator(
                              color: Color(orange),
                            )
                          : Container(),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cubit.login
                              ? const Text("Don't have an account?")
                              : const Text("Already have an account?"),
                          GestureDetector(
                            onTap: cubit.changeLogin,
                            child: Text(
                              cubit.login ? 'Sign Up' : 'log in',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ],
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
