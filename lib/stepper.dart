import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'core/string.dart';
import 'login/Sign_up.dart';

class StepperScreen extends StatelessWidget {
  const StepperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    PageController controller = PageController();
    return Scaffold(
      body: Stack(alignment: const Alignment(-0.7, 0.35), children: [
        PageView(
          controller: controller,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assest/Stepper2.jpg'),
                      fit: BoxFit.fill)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Prepare your favorite meal!",
                              style: TextStyle(
                                  fontSize: size.width * .06,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "lorem ipsum dolor sit amet lorem ipsum dolor sit amet",
                              style: TextStyle(
                                  fontSize: size.width * .03,
                                  color: Colors.white54),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                          ]),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool(
                                  STORAGE_USER_GETSTART_KEY, true);
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ));
                            },
                            child: const Text(
                              "Skip",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                        GestureDetector(
                            onTap: () {
                              controller.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeIn);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF88500),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                "Next",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                    )
                  ]),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assest/Stepper3.jpg'),
                      fit: BoxFit.fill)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Prepare your favorite meal!",
                              style: TextStyle(
                                  fontSize: size.width * .06,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "lorem ipsum dolor sit amet lorem ipsum dolor sit amet",
                              style: TextStyle(
                                  fontSize: size.width * .03,
                                  color: Colors.white54),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                          ]),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ));
                              await prefs.setBool(
                                  STORAGE_USER_GETSTART_KEY, true);
                            },
                            child: const Text(
                              "Skip",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                        GestureDetector(
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool(
                                  STORAGE_USER_GETSTART_KEY, true);
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ));
                              // controller.nextPage(
                              //     duration: Duration(milliseconds: 400),
                              //     curve: Curves.easeIn);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF88500),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                "Next",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                    )
                  ]),
            ),
          ],
        ),
        SmoothPageIndicator(
            controller: controller, // PageController
            count: 2,
            effect: CustomizableEffect(
                dotDecoration: DotDecoration(
                  borderRadius: BorderRadius.circular(5),
                  width: 16,
                  height: 3,
                ),
                activeDotDecoration: DotDecoration(
                  borderRadius: BorderRadius.circular(5),
                  width: 16,
                  height: 3,
                  color: const Color(0xFFE88500),
                )), // your preferred effect
            onDotClicked: (index) {}),
      ]),
    );
  }
}
