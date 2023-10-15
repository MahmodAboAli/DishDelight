import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../chat/chat_screen.dart';
import '../cubit/meal_cubit.dart';

class MealScreen extends StatelessWidget {
  final String sction;
  const MealScreen({super.key, required this.sction});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MealCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: (state is loadingMealState)
              ? const Center(child: CircularProgressIndicator())
              : (cubit.Meals.length == 0)
                  ? Center(
                      child: Text("No Meals"),
                    )
                  : ListView.builder(
                      itemCount: cubit.Meals.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () async {
                            await cubit.GoChat(cubit.Meals[index].id ?? "");
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  title: cubit.Meals[index].title ??
                                      "Anknown Meal"),
                            ));
                          },
                          child: Column(children: [
                            Text(cubit.Meals[index].title ?? "No response"),
                            Image(
                                image: NetworkImage(
                                    cubit.Meals[index].src.toString()))
                          ]),
                        );
                      },
                    ),
        );
      },
    );
  }
}
