// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../cubit/meal_cubit.dart';
// import '../screen/meal_screen.dart';

// class MealSection extends StatelessWidget {
//   final String image;
//   final String sction;
//   const MealSection({super.key, required this.image, required this.sction});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<MealCubit, MealState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         var cubit = MealCubit.get(context);
//         return InkWell(
//           child: Image(
//             image: NetworkImage(image),
//           ),
//           onTap: () {
//             cubit.FilterMeals();
//             Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => MealScreen(
//                       sction: sction,
//                     )));
//           },
//         );
//       },
//     );
//   }
// }
