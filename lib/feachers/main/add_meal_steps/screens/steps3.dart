import 'package:DISH_DELIGhTS/feachers/main/main_page/screens/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/meal_cubit.dart';
import '../../../../core/colors.dart';
import '../../../../core/userdata.dart';
import '../../meal_detial_page/models/meal_detial_model.dart';

class Steps3 extends StatelessWidget {
  Steps3({super.key});

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final sizewidth = MediaQuery.of(context).size.width / 393;
    final sizehight = MediaQuery.of(context).size.height / 850;
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = MealCubit.get(context);
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
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
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
                                color: Color(orange),
                              ),
                              width: sizewidth * 98,
                              height: 7,
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: Color(orange),
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
                                color: Color(orange),
                              ),
                              width: sizewidth * 98,
                              height: 7,
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: Color(orange),
                            child: Text(
                              "3",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(white),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    height: sizehight * 620,
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Add preparation way:",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFF37474F)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: sizehight * 540,
                                child: ListView.builder(
                                  itemCount: cubit.prepration.length + 1,
                                  itemBuilder: (context, index) => index ==
                                          cubit.prepration.length
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              child: const Text(
                                                "+Add way",
                                                style: TextStyle(
                                                    color: Color(Grey)),
                                              ),
                                              onTap: () {
                                                cubit
                                                    .incrementListofprepration();
                                              },
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    right: sizewidth * 40),
                                                child: const Text(
                                                  "-remove way",
                                                  style: TextStyle(
                                                      color: Color(Grey)),
                                                ),
                                              ),
                                              onTap: () {
                                                cubit
                                                    .dicrementListofprepration();
                                              },
                                            ),
                                          ],
                                        )
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('${index + 1}.'),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  right: 8, bottom: 8),
                                              width: sizewidth * 300,
                                              child: TextFormField(
                                                onChanged: (value) {
                                                  cubit.addprepration(
                                                      index, value);
                                                },
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: 5,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide.none),
                                                  filled: true,
                                                  fillColor:
                                                      const Color(lightGrey),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          BorderSide.none),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF37474F),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: (state is loadingState)
                        ? Center(child: CircularProgressIndicator())
                        : TextButton(
                            onPressed: () async {
                              await cubit.AddTheMeal(
                                  meal: MealDetial(
                                userid: userdata.accessToken,
                                ingredient: cubit.ingredient,
                                rate: 0,
                                numOfrate: 0,
                                valueOfIngredient: cubit.valuesofingredient,
                                steps: cubit.prepration,
                                descreption: cubit.description,
                                src: cubit.str,
                                title: cubit.title,
                                section: cubit.catigoryName,
                                time: cubit.timeMeal + "m",
                              ));
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => FirstPage(),
                                  ),
                                  (route) => false);
                              await cubit.FilterMeals();
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                  color: Color(0XFFFFFFFF),
                                  fontSize: 20,
                                  fontFamily: 'Tajawal'),
                            ),
                          ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
