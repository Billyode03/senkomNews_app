import 'package:flutter/material.dart';
import 'package:senkom_news_app/app/constant/color_constant.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:my_app/constant/color_constant.dart';

class WebSwipeView extends StatefulWidget {
  @override
  _WebSwipeViewState createState() => _WebSwipeViewState();
}

class _WebSwipeViewState extends State<WebSwipeView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> urls = [
    'https://www.senkom.or.id/',
    'https://www.youtube.com/@SenkomTV',
  ];

  // Jangan instantiate WebViewController() — terima dari onWebViewCreated
  late List<WebViewController?> controllers;

  @override
  void initState() {
    super.initState();
    controllers = List<WebViewController?>.filled(urls.length, null);
  }

  String getWebPageTitle(String url) {
    return Uri.parse(url).host;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.goldYellow,
        title: Text(getWebPageTitle(urls[_currentPage])),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              final ctrl = controllers[_currentPage];
              if (ctrl != null) {
                try {
                  await ctrl.reload();
                } catch (e) {
                  // fallback kalau reload gagal
                  await ctrl.loadUrl(urls[_currentPage]);
                }
              } else {
                // controller belum terinisialisasi (misal: halaman belum dibuat)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('WebView belum siap, coba sebentar lagi')),
                );
              }
            },
          )
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: urls.length,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        itemBuilder: (context, index) {
          return WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: urls[index],
            onWebViewCreated: (controller) {
              // simpan controller yang diberikan oleh plugin
              controllers[index] = controller;
            },
            onPageStarted: (url) {
              // opsional: update judul dari host jika mau realtime
              if (index == _currentPage) {
                setState(() {}); // memaksa rebuild appbar title jika diperlukan
              }
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.web), label: "Website"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library), label: "YouTube"),
        ],
      ),
    );
  }
}
