import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/meal_cubit.dart';

class ChatScreen extends StatelessWidget {
  final String title;
  const ChatScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MealCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () async {
                    cubit.addNeeds("name1", 1);
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.send),
              onPressed: () async {
                await cubit.sendMessage();
              }),
          body: (state is loadingState)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(children: [
                  TextField(
                    controller: cubit.textController,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: cubit.msgcontentList.length,
                    itemBuilder: (context, index) => Container(
                      color: Colors.green,
                      child: Text(
                          cubit.msgcontentList[index].content ?? "nothing"),
                    ),
                  ))
                ]),
        );
      },
    );
  }
}
