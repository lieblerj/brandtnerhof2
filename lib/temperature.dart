import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class TemperatureView extends StatelessWidget {
  const TemperatureView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Temperaturgraph'),
      ),
      body: PhotoView(
        imageProvider:
            NetworkImage('https://cacti.brandtnerhof.at/temp_last_day.png'),
        minScale: PhotoViewComputedScale.contained * 0.9,
        maxScale: PhotoViewComputedScale.covered * 2,
        initialScale: PhotoViewComputedScale.contained,
      ),
    );
  }
}
