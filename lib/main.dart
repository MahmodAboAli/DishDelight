import 'package:DISH_DELIGhTS/cubit/meal_cubit.dart';
import 'package:DISH_DELIGhTS/firebase_options.dart';
import 'package:DISH_DELIGhTS/feachers/main/main_page/cubit/home_cubit.dart';
import 'package:DISH_DELIGhTS/feachers/Auth/cubit/login_cubit.dart';
import 'package:DISH_DELIGhTS/feachers/main/meal_detial_page/cubit/meal_detial_cubit.dart';
import 'package:DISH_DELIGhTS/feachers/Auth/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/colors.dart';
import 'core/string.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // prefs.clear();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool isgetStart = preferences.getBool(STORAGE_USER_GETSTART_KEY) ?? false;
  bool islogin = preferences.getBool(STORAGE_USER_LOGIN_KEY) ?? false;

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => MealCubit()
          ..getData()
          ..FilterMeals(),
      ),
      BlocProvider(create: (context) => HomeCubit()),
      BlocProvider(create: (context) => LoginCubit()),
      BlocProvider(
        create: (context) => MealDetialCubit(),
      ),
    ],
    child: MyApp(
      isGetStart: isgetStart,
      islogin: islogin,
    ),
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool islogin;
  bool isGetStart;

  MyApp({super.key, required this.islogin, required this.isGetStart});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (BuildContext context, Widget? child) => MaterialApp(
          theme: ThemeData(
            // colorScheme: ColorScheme(primary: Color(orange)),
            // toggleableActiveColor: Color(orange),
            colorSchemeSeed: Color(orange),
            // primaryColor: const Color(orange)
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(
            isgetStart: isGetStart,
            islogin: islogin,
          )),
    );
  }
}

// class SplashScreen extends StatefulWidget {
//   final isGetStart;
//   final islogin;
//   const SplashScreen({super.key, this.isGetStart, this.islogin});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     @override
//     @override
//     void initState() {
//       super.initState();

//       Timer(
//           Duration(seconds: 1),
//           () => Navigator.of(context).pushReplacement(
//             MaterialPageRoute(
//                 builder: (context) =>
//                  !widget.isGetStart
//                     ? StepperScreen()
//                     : widget.islogin
//                         ? FirstPage()
//                         : SignUp(),
//               )));
//     }

//     return Scaffold(
//       backgroundColor: Color(white),
//       body: Center(
//           child: Image(
//         image: AssetImage('assest/logo.png'),
//       )),
//     );
//   }
// }
