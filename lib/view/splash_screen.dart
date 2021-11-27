import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_fast_paraphrase/controller/controller.dart';
import 'package:the_fast_paraphrase/variables/st_variables.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.put(Controller());
    return GetBuilder<Controller>(builder: (controller){
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset('assets/logo.png'),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      StVariables.appName,
                      textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width*.07,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 300),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
