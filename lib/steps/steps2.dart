import 'package:DISH_DELIGhTS/steps/steps3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/colors.dart';
import '../cubit/meal_cubit.dart';

class Steps2 extends StatelessWidget {
  Steps2({super.key});

  @override
  Widget build(BuildContext context) {
    final sizewidth = MediaQuery.of(context).size.width / 393;
    final sizehight = MediaQuery.of(context).size.height / 850;
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealCubit.get(context);

        TextEditingController DescriptionController =
            cubit.DescriptionController;
        TextEditingController spentController = cubit.spentController;
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
              // physics: const NeverScrollableScrollPhysics(),
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
                              width: sizewidth * 108,
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
                                color: Color(Grey),
                              ),
                              width: sizewidth * 108,
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
                                height: 10,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                "Add time spent:",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFF37474F)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Form(
                                child: TextFormField(
                                  // onSaved: (newValue) {
                                  //   if (formkey.currentState!.validate()) {
                                  //     formkey.currentState!.save();
                                  //   }
                                  // }
                                  controller: spentController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: const Color(lightGrey),
                                    hintText: 'mins',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Add description:",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFF37474F)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                // onSaved: (newValue) {
                                //   if (formkey.currentState!.validate()) {
                                //     formkey.currentState!.save();
                                //   }
                                // },
                                controller: DescriptionController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: const Color(lightGrey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Add ingredient:",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFF37474F)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: sizehight * 180,
                                child: ListView.builder(
                                  itemCount: cubit.ingredient.length + 1,
                                  itemBuilder: (context, index) => index ==
                                          cubit.ingredient.length
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              child: const Text(
                                                "+Add ingredient",
                                                style: TextStyle(
                                                    color: Color(Grey)),
                                              ),
                                              onTap: () {
                                                cubit.incrementList();
                                              },
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    right: sizewidth * 40),
                                                child: const Text(
                                                  "-remove ingredient",
                                                  style: TextStyle(
                                                      color: Color(Grey)),
                                                ),
                                              ),
                                              onTap: () {
                                                cubit.dicrementList();
                                              },
                                            ),
                                          ],
                                        )
                                      : Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: 20,
                                                  child: Text('${index + 1}.')),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  height: 40,
                                                  width: sizewidth * 200,
                                                  child: TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty)
                                                        return 'input the ingredients';
                                                      return null;
                                                    },
                                                    onChanged: (newValue) {
                                                      cubit.addIngredient(
                                                          index, newValue);
                                                      print(cubit
                                                          .ingredient[index]);
                                                    },
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      filled: true,
                                                      fillColor: const Color(
                                                          lightGrey),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Color(Grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: DropdownButton(
                                                  onChanged: (value) {},
                                                  value:
                                                      cubit.valuesofingredient[
                                                          index],
                                                  items: [
                                                    DropdownMenuItem(
                                                      value: 1,
                                                      child: Text('1'),
                                                      onTap: () {
                                                        cubit.changevalue(
                                                            index, 1);
                                                      },
                                                    ),
                                                    DropdownMenuItem(
                                                      value: .75,
                                                      child: Text('3/4'),
                                                      onTap: () {
                                                        cubit.changevalue(
                                                            index, .75);
                                                      },
                                                    ),
                                                    DropdownMenuItem(
                                                      value: .5,
                                                      child: Text('1/2'),
                                                      onTap: () {
                                                        cubit.changevalue(
                                                            index, .5);
                                                      },
                                                    ),
                                                    DropdownMenuItem(
                                                      value: .25,
                                                      child: Text('1/4'),
                                                      onTap: () {
                                                        cubit.changevalue(
                                                            index, .25);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
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
                    child: TextButton(
                      onPressed: () {
                        cubit.Step2don(
                            descrip: DescriptionController.text,
                            time: spentController.text);

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Steps3(),
                        ));
                      },
                      child: const Text(
                        'Next',
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







                                // child: DropdownMenu(dropdownMenuEntries: [
                                //   DropdownMenuEntry(value: 0.25, label: '1/4'),
                                //   DropdownMenuEntry(value: 0.5, label: '1/2'),
                                //   DropdownMenuEntry(value: 0.75, label: '3/4'),
                                //   DropdownMenuEntry(value: 1, label: '1'),
                                // ]),

//                         child: Column(
                                //   children: <Widget>[
                                //     SelectDropList(
                                //       itemSelected:optionItemSelected,
                                //       dropListModel:dropListModel,
                                //       showIcon: false,     // Show Icon in DropDown Title
                                //       showArrowIcon: true,     // Show Arrow Icon in DropDown
                                //       showBorder: true,
                                //       paddingTop: 0,
                                //       suffixIcon: Icons.arrow_drop_down,
                                //       containerPadding: const EdgeInsets.all(10),
                                //       icon: const Icon(Icons.person,color: Colors.black),
                                //       onOptionSelected:(optionItem){
                                //         optionItemSelected = optionItem;

                                //       },
                                //     )
                                //   ],
                                // ),