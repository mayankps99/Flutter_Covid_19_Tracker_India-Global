import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DescriptionPage extends StatelessWidget {
  static String tag = 'description-page';
  DescriptionPage(this.urlnews,this.title);
  final String urlnews;
  final String title;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xff348A7B),
        title: new Text(
          title,
          style: new TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: WebView(
        initialUrl: urlnews,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}