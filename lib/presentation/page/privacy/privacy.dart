import 'package:flutter/material.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://spotright-dev.nogamsung.com/doc/privacy'));

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: DefaultAppBar(title: "개인정보처리방침", hasBackButton: true,),
      body: WebViewWidget(
        controller: webViewController,
      ),
    ));
  }
}
