import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutWidget extends StatefulWidget {
  const AboutWidget({super.key});  
  @override
   State<AboutWidget> createState() => _AboutWidgetState(); 
}

class _AboutWidgetState extends State<AboutWidget> {
  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";

  @override
  initState() {
    super.initState();

    // Be sure to add this line if `PackageInfo.fromPlatform()` is called before runApp()
    WidgetsFlutterBinding.ensureInitialized();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();

        appName = packageInfo.appName;
        packageName = packageInfo.packageName;
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
    } on PlatformException {
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      //_projectVersion = projectVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info),
      onPressed: () {
        showAboutDialog(
          context: context,
          applicationName: 'Brandtnerhof',
          applicationVersion: version,
          applicationIcon: Image.asset("assets/icon.png"),
        );
      },
    );
  }
}
