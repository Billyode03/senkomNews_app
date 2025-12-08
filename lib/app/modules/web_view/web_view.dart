import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:senkom_news_app/app/constant/color_constant.dart';
import 'package:senkom_news_app/app/constant/image_constant.dart';
import 'package:senkom_news_app/app/constant/text_constant.dart';
import 'package:senkom_news_app/app/modules/favorite/favorite_screen.dart';
import 'package:senkom_news_app/app/modules/prov_kota/prov_kota_screen.dart';
import 'package:senkom_news_app/app/modules/rating/rating_screen.dart';
import 'package:senkom_news_app/app/modules/tentang_kami/tentang_kami.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebSwipeView extends StatefulWidget {
  @override
  _WebSwipeViewState createState() => _WebSwipeViewState();
}

class _WebSwipeViewState extends State<WebSwipeView> {
  final GlobalKey<SliderDrawerState> _drawerKey =
      GlobalKey<SliderDrawerState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> urls = [
    'https://www.senkom.or.id/',
    'https://www.youtube.com/@SenkomTV',
  ];

  late List<WebViewController?> controllers;
  late List<bool> _errorState;
  late List<bool> _loadingState;

  @override
  void initState() {
    super.initState();
    controllers = List<WebViewController?>.filled(urls.length, null);
    _errorState = List<bool>.filled(urls.length, false);
    _loadingState = List<bool>.filled(urls.length, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SliderDrawer(
          animationDuration: Duration.microsecondsPerMillisecond,
          key: _drawerKey,
          slideDirection: SlideDirection.topToBottom, // 👈 Versi baru
          sliderOpenSize: 290,

          appBar: SliderAppBar(
            config: SliderAppBarConfig(
              // 👈 wajib sekarang
              backgroundColor: ColorConstant.goldYellow,
              drawerIconColor: Colors.white,
              title: Center(
                child: Text(
                  "S E N K O M   N E W S ",
                  style: TextStyleUsable.titleBig,
                ),
              ),
            ),
          ),

          slider: _buildDrawerMenu(),
          child: PageView.builder(
              controller: _pageController,
              itemCount: urls.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                if (_errorState[index]) {
                  return _buildNoInternetView(index);
                }

                return Stack(
                  children: [
                    WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: urls[index],
                      onWebViewCreated: (controller) {
                        controllers[index] = controller;
                      },
                      onPageFinished: (_) {
                        setState(() => _loadingState[index] = false);
                      },
                      onWebResourceError: (_) {
                        setState(() {
                          _errorState[index] = true;
                          _loadingState[index] = false;
                        });
                      },
                    ),
                    if (_loadingState[index])
                      const Center(child: CircularProgressIndicator()),
                  ],
                );
              }),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        selectedItemColor: Colors.amber[700],
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.web),
            label: "Website",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: "YouTube",
          ),
        ],
      ),
    );
  }

  Widget _buildNoInternetView(int index) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageConstant.noConnect, // ganti sesuai file lo
            width: 200,
          ),
          const SizedBox(height: 20),
          const Text(
            "Tidak ada koneksi internet",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
              ColorConstant.goldYellow,
            )),
            onPressed: () async {
              setState(() {
                _loadingState[index] = true;
                _errorState[index] = false;
              });
              controllers[index]?.reload();
            },
            child: const Text("Coba Lagi"),
          )
        ],
      ),
    );
  }

  Widget _buildDrawerMenu() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorConstant.goldYellow, // orange muda
            ColorConstant.redMaroon, // orange tua
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------------- PROFILE ---------------------------
          Center(
            child: Column(
              children: [
                Image.asset(
                  ImageConstant.logoAwal,
                  height: 55,
                  width: 55,
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // -------------------------- MENU GRID -------------------------
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2.8,
            mainAxisSpacing: 4,
            children: [
              _menuItem(Icons.home, "Beranda", () {
                _drawerKey.currentState?.closeSlider();
                _pageController.jumpToPage(0);
              }),
              _menuItem(Icons.favorite, "Favorite", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteScreen(),
                  ),
                );
              }),
              _menuItem(Icons.home_work_rounded, "Prov - Kota", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProvKotaScreen(),
                  ),
                );
              }),
              _menuItem(Icons.star, "Rating", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RatingScreen(),
                  ),
                );
              }),
              _menuItem(Icons.star, "Tentang Kami", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TentangKamiScreen(),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String label, VoidCallback action) {
    return InkWell(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.amber[700], size: 22),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
