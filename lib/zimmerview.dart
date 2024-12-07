import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ZimmerView extends StatefulWidget {
  final String roomName;
  const ZimmerView({super.key, required this.roomName});

  @override
  _ZimmerViewState createState() => _ZimmerViewState();
}

class _ZimmerViewState extends State<ZimmerView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    String title = getRoomTitle(widget.roomName);
    String roomLink = getRoomLink(widget.roomName);

    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
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
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(roomLink));

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: WebViewWidget(controller: controller),
    );
  }

  String getRoomLink(String roomName) {
    String link;

    switch (roomName.toLowerCase()) {
      case 'waidring':
      case 'lofer':
      case 'penthouse':
        link =
            'https://brandtnerhof.at/waidring-pillerseetal-und-lofer-saalachtal/wohnung-${roomName.toLowerCase()}';
        break;
      default:
        link = 'https://brandtnerhof.at';
    }
    return link;
  }

  String getRoomTitle(String roomName) {
    String title;

    switch (roomName) {
      case 'Waidring':
      case 'Lofer':
      case 'Penthouse':
      default:
        title = 'Wohnung $roomName';
    }
    return title;
  }
}
