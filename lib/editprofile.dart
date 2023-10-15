// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'core/colors.dart';
import 'cubit/meal_cubit.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  // void _performSignIn() {
  //   String FirstName = EditFirstNameController.text;
  //   String LastName = EditLastNameController.text;
  //   String email = EditemailController.text;
  //   String password = EditpasswordController.text;
  // }

  @override
  Widget build(BuildContext context) {
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
        }

        final TextEditingController EditFirstNameController =
            cubit.EditFirstNameController;
        final TextEditingController EditLastNameController =
            cubit.EditLastNameController;
        final TextEditingController EditemailController =
            cubit.EditemailController;
        final TextEditingController EditpasswordController =
            cubit.EditpasswordController;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 40.h, bottom: 10.h),
                  width: double.infinity,
                  color: const Color(orange),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            bottom: 16.h, left: 12.w, top: 10.h),
                        width: 24.w,
                        height: 24.h,
                        padding: const EdgeInsets.all(1),
                        child: GestureDetector(
                          child: const Icon(Icons.arrow_back,
                              color: Color(0XFF37474F)),
                          onTap: () {
                            Navigator.of(context).pop();
                            print('object');
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.w),
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                              color: Color(0XFF37474F),
                              fontSize: 24,
                              fontFamily: 'poppins'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                CircleAvatar(
                  radius: 45, // Adjust the radius as needed
                  backgroundImage: NetworkImage(cubit.userdata.photoUrl ?? ""),
                ),
                SizedBox(
                  height: 20.h,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        color: const Color(0XFFFFB74D),
                        onPressed: () {
                          showPicker(context);
                        },
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                          right: 50,
                        ),
                        child: const Text(
                          'Edit profile picture',
                          style: TextStyle(color: Color(0XFFFFB74D)),
                        )),
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.only(right: 210),
                  child: Text(
                    'Edit First Name',
                    style: TextStyle(color: Color(0XFF37474F), fontSize: 15),
                  ),
                ),

                Container(
                  height: 34,
                  width: 241,
                  margin: const EdgeInsets.only(right: 75),
                  decoration: BoxDecoration(
                    color: const Color(0XFFE1E1E1),
                    border: Border.all(
                      color: const Color(0XFFE1E1E1),
                    ),
                    borderRadius: BorderRadius.circular(
                        7), // Half of width or height for perfect circle
                  ),
                  child: TextField(
                    controller: EditFirstNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        fillColor: const Color(0XFFE1E1E1),
                        suffixIcon: const Icon(
                          Icons.edit,
                          color: Color(0XFFFFB74D),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                            color: Color(0XFFE1E1E1),
                          ),
                        )),
                  ),
                ),
                //     ),

                const SizedBox(
                  height: 20,
                ),

                const Padding(
                  padding: EdgeInsets.only(
                    right: 210,
                  ),
                  child: Text(
                    'Edit Last Name',
                    style: TextStyle(color: Color(0XFF37474F), fontSize: 15),
                  ),
                ),

                Container(
                  height: 34,
                  width: 241,
                  margin: const EdgeInsets.only(right: 75),
                  decoration: BoxDecoration(
                    color: const Color(0XFFE1E1E1),
                    border: Border.all(
                      color: const Color(0XFFE1E1E1),
                    ),
                    borderRadius: BorderRadius.circular(
                        7), // Half of width or height for perfect circle
                  ),
                  child: TextFormField(
                    controller: EditLastNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Color(0XFFFFB74D),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Color(0XFFE1E1E1),
                        ),
                      ),
                    ),
                    cursorColor: const Color(0XFFFFB74D),
                    // style: const TextStyle(
                    //   color: Color(0XFF7F7F7F),
                    // ),
                  ),
                ),

                // const SizedBox(
                //   height: 20,
                // ),

                // const Padding(
                //   padding: EdgeInsets.only(right: 275),
                //   child: Text(
                //     'Email',
                //     style: TextStyle(color: Color(0XFF37474F), fontSize: 15),
                //   ),
                // ),

                // Container(
                //   height: 34,
                //   width: 241,
                //   margin: const EdgeInsets.only(right: 75),
                //   decoration: BoxDecoration(
                //     color: const Color(0XFFE1E1E1),
                //     border: Border.all(
                //       color: const Color(0XFFE1E1E1),
                //     ),
                //     borderRadius: BorderRadius.circular(
                //         7), // Half of width or height for perfect circle
                //   ),
                //   child: TextField(
                //     controller: EditemailController,
                //     keyboardType: TextInputType.emailAddress,
                //     decoration: InputDecoration(
                //         enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(7),
                //       borderSide: const BorderSide(
                //         color: Color(0XFFE1E1E1),
                //       ),
                //     )),
                //     cursorColor: const Color(0XFFFFB74D),
                //     // style: const TextStyle(
                //     //   color: Color(0XFF7F7F7F),
                //     // ),
                //   ),
                // ),

                // const SizedBox(
                //   height: 20,
                // ),

                // const Padding(
                //   padding: EdgeInsets.only(right: 240),
                //   child: Text(
                //     'Password',
                //     style: TextStyle(color: Color(0XFF37474F), fontSize: 15),
                //   ),
                // ),

                // Container(
                //   height: 34,
                //   width: 241,
                //   margin: const EdgeInsets.only(right: 75),
                //   decoration: BoxDecoration(
                //     color: const Color(0XFFE1E1E1),
                //     border: Border.all(
                //       color: const Color(0XFFE1E1E1),
                //     ),
                //     borderRadius: BorderRadius.circular(
                //         7), // Half of width or height for perfect circle
                //   ),
                //   child: TextFormField(
                //     controller: EditpasswordController,
                //     keyboardType: TextInputType.visiblePassword,
                //     obscureText: !cubit.isObscuredpassword,
                //     decoration: InputDecoration(
                //         suffixIcon: IconButton(
                //           icon: Icon(
                //             cubit.isObscuredpassword
                //                 ? Icons.visibility
                //                 : Icons.visibility_off,
                //           ),
                //           onPressed: () {
                //             cubit.changeObscuredOfPassword();
                //           },
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(7),
                //           borderSide: const BorderSide(
                //             color: Color(0XFFE1E1E1),
                //           ),
                //         )),
                //     cursorColor: const Color(0XFFFFB74D),
                //     // style: const TextStyle(
                //     //   color: Color(0XFF7F7F7F),
                //     // ),
                //   ),
                // ),

                SizedBox(
                  height: 300.h,
                ),

                Container(
                  width: 400.w,
                  height: 47.h,
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF37474F),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      await cubit.editprofile(
                          // email: EditemailController.text,
                          photo: cubit.str,
                          // password: EditpasswordController.text,
                          FirstName: EditFirstNameController.text,
                          LastName: EditLastNameController.text);
                    },
                    child: const Text(
                      'Save ',
                      style: TextStyle(
                          color: Color(0XFFFFFFFF),
                          fontSize: 20,
                          fontFamily: 'Tajawal'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // void _saveCounterChanges() {
  //   setState(() {});
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('Counter changes saved successfully!')),

  //   );
  // }
}
