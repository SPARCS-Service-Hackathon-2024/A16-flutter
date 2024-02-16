import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static const String _url = 'http://localhost:5173/login';

  Future<OAuthToken> _getToken() async {
    if (await isKakaoTalkInstalled()) {
      return await UserApi.instance.loginWithKakaoTalk();
    }
    return await UserApi.instance.loginWithKakaoAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          onWebViewCreated: (controller) {
            controller.addJavaScriptHandler(
                handlerName: 'loginWithKakao',
                callback: (args) async {
                  final token = await _getToken();
                  return token.idToken;
                });
          },
          onConsoleMessage: (_, message) => print(message),
          initialUrlRequest: URLRequest(url: Uri.parse(_url)),
          initialOptions: InAppWebViewGroupOptions(
            ios: IOSInAppWebViewOptions(
              allowsInlineMediaPlayback: true,
            ),
          ),
        ),
      ),
    );
  }
}
