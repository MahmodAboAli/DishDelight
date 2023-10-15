// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'cubit/login_cubit.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<LoginCubit, LoginState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         var cubit = LoginCubit.get(context);
//         return Scaffold(
//           body: SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 children: [
//                   Container(
//                     height: 90,
//                   ),
//                   cubit.getImage
//                       ? Image.network(cubit.str)
//                       // Container(child: Text("Get data"),)
//                       : Container(
//                           height: 60,
//                         ),
//                   Text(cubit.idtoken ?? "no id"),
//                   TextButton(
//                     child: Text("Google"),
//                     onPressed: () async {
//                       // await cubit.authenticate("Mahmoud4879384539@gmail.com",
//                       //     "123123123", 'urlSegment', false);
//                       // cubit.handleSignin();
//                       // await cubit.imgFromGallery();
//                       // await cubit.uploadFile();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   login() {}
// }
