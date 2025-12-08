import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TentangKamiScreen extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<TentangKamiScreen> {
  late WebViewController _controller;
  String _pageTitle =
      'https://www.senkom.or.id/p/latar-belakang-senkom-mitra-polri.html';
  final String _url =
      'https://www.senkom.or.id/p/latar-belakang-senkom-mitra-polri.html';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle),
      ),
      body: WebView(
        initialUrl: _url,
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.loadUrl(_url); // Reloads the WebView with the initial URL
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
