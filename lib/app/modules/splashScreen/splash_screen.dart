import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:senkom_news_app/app/constant/image_constant.dart';
import 'package:senkom_news_app/app/modules/web_view/web_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset(
          ImageConstant.logoAwal,
          height: 120,
          width: 120,
        ),
      ),
      duration: const Duration(milliseconds: 3000),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: WebSwipeView(),
    );
  }
}
