import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final InAppWebViewController _controller;
  static const String _url = 'https://wayu.vercel.app/Login';

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      onWebViewCreated: (controller) => _controller = controller,
      initialUrlRequest: URLRequest(url: Uri.parse(_url)),
    );
  }
}
