import 'package:flutter/material.dart';
import 'package:senkom_news_app/app/constant/image_constant.dart';
import 'package:senkom_news_app/app/constant/text_constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Image.asset(
                ImageConstant.logoAwal,
                height: 120,
                width: 120,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "S E N K O M   N E W S",
              style: TextStyleUsable.openingLogo,
            ),
          ],
        ),
      ),
    );
  }
}
