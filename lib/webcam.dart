import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webcam extends StatefulWidget {
  final WebcamSelection selection;

  const Webcam({super.key, required this.selection});
  @override
  State<Webcam> createState() => _WebcamState();
}

enum WebcamSelection { tal, berg, pantal, felsen }

String talurl = 'https://axis.brandtnerhof.at/tal/';
String bergurl = 'https://axis.brandtnerhof.at/berg/';
String pantalurl = 'https://axis.brandtnerhof.at/pantal/';
String felsenurl = 'https://axis.brandtnerhof.at/felsen/';
String title = '';

class _WebcamState extends State<Webcam> {
  String _webcamlink = '';
  bool _appbarvisible = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.selection) {
      case WebcamSelection.berg:
        _webcamlink = bergurl;
        title = 'Webcam Berg';
        break;
      case WebcamSelection.tal:
        _webcamlink = talurl;
        title = 'Webcam Tal';
        break;
      case WebcamSelection.pantal:
        _webcamlink = pantalurl;
        title = 'Webcam Panorama Tal';
        break;
      case WebcamSelection.felsen:
        _webcamlink = felsenurl;
        title = 'Webcam Felsen';
        break;
      default:
    }

    // check screen orientation
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      _appbarvisible = false;
    } else {
      _appbarvisible = true;
    }

    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_webcamlink));

    return Scaffold(
      appBar: _appbarvisible
          ? AppBar(
              title: Text(title),
            )
          : null,
      body: WebViewWidget(controller: controller),
    );
  }
}
