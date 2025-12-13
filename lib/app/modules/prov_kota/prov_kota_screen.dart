import 'package:flutter/material.dart';
import 'package:senkom_news_app/app/constant/color_constant.dart';

class ProvKotaScreen extends StatelessWidget {
  const ProvKotaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: (ColorConstant.goldYellow),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text("Halaman Prov Kota"),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 180,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
