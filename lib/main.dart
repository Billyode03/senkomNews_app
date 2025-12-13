import 'package:flutter/material.dart';
import 'package:senkom_news_app/app/modules/home/home_screen.dart';
import 'package:senkom_news_app/app/modules/splashScreen/splash_screen.dart';
import 'package:senkom_news_app/app/modules/web_view/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MainApp()); 
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SplashScreen(),
        ),
      ),
    );
  }
}
