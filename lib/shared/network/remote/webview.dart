import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewer extends StatelessWidget {
  WebViewer({super.key, required this.url});
  final String url;

  late final WebViewController controller = WebViewController()
    ..loadRequest(
      Uri.parse(url),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Image(
          image: AssetImage("assets/imgs/logo.png"),
          height: 49,
        ),
        centerTitle: true,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          } else {
            throw 'Could not launch $url';
          }
        },
        child: const Icon(Icons.open_in_browser_outlined),
      ),
    );
  }
}
