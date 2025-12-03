import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:senkom_news_app/app/constant/color_constant.dart';
import 'package:senkom_news_app/app/constant/image_constant.dart';
import 'package:senkom_news_app/app/constant/text_constant.dart';
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

  @override
  void initState() {
    super.initState();
    controllers = List<WebViewController?>.filled(urls.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SliderDrawer(
          animationDuration: Duration.microsecondsPerMillisecond,
          key: _drawerKey,
          slideDirection: SlideDirection.topToBottom, // 👈 Versi baru
          sliderOpenSize: 230,

          appBar: SliderAppBar(
            config: SliderAppBarConfig(
              // 👈 wajib sekarang
              backgroundColor: ColorConstant.goldYellow,
              drawerIconColor: Colors.white,
              title: Center(
                child: Text(
                  "S E N K O M   N E W S",
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
              return WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: urls[index],
                gestureRecognizers: {
                  Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer(),
                  ),
                },
                onWebViewCreated: (controller) {
                  controllers[index] = controller;
                },
              );
            },
          ),
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
          BottomNavigationBarItem(icon: Icon(Icons.web), label: "Website"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library), label: "YouTube"),
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
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(ImageConstant.logoAwal),
                  // backgroundImage: Image.asset(ImageConstant.logoAwal),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Menu",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // -------------------------- MENU GRID -------------------------
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 2.8,
            mainAxisSpacing: 6,
            children: [
              _menuItem(Icons.home, "Home", () {
                _drawerKey.currentState?.closeSlider();
                _pageController.jumpToPage(0);
              }),
              _menuItem(Icons.favorite, "Likes", () {}),
              _menuItem(Icons.add_circle, "Post", () {}),
              _menuItem(Icons.settings, "Setting", () {}),
              _menuItem(Icons.notifications, "Notification", () {}),
              _menuItem(Icons.logout, "Logout", () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
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
