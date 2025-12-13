import 'package:flutter/material.dart';
import 'package:senkom_news_app/app/constant/color_constant.dart';
import 'package:senkom_news_app/app/constant/image_constant.dart';
import 'package:senkom_news_app/app/constant/text_constant.dart';
import 'package:senkom_news_app/app/global_widget/globalButtonWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _AppRatingScreenState();
}

class _AppRatingScreenState extends State<RatingScreen> {
  double userRating = 0.0;
  void showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nilai Aplikasi"),
        content: const Text("Terima kasih sudah memberikan rating!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Penilaian Aplikasi',
          style: TextStyleUsable.title_two,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left_sharp,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(child: Image.asset(ImageConstant.ratingImg)),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Bantu Kami Menjadi Lebih Baik!',
                  style: TextStyleUsable.title_two,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Feedback Anda sangat berharga bagi kami untuk terus mengembangkan BentorTa' dan memberikan pengalaman terbaik bagi pengguna",
                  style: TextStyleUsable.title_two,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 290),
              // GlobalButtonWidget(
              //   onTap: () => showRatingDialog(context),
              //   spacing: 10,
              //   text: 'Beri Nilai',
              //   textColor: ColorConstant.white,
              // ),
              GlobalButtonWidget(
                onTap: () async {
                  final Uri playStoreUrl = Uri.parse(
                    'https://play.google.com/store/apps/details?id=com.supercell.clashofclans',
                  );
                  if (!await launchUrl(playStoreUrl,
                      mode: LaunchMode.externalApplication)) {}
                  {
                    debugPrint('Tidak bisa membuka URL Play Store');
                  }
                },
                spacing: 10,
                text: 'Beri Nilai',
                textColor: ColorConstant.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
