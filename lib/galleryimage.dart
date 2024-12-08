import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class GalleryImage extends StatelessWidget {
  final String imageUrl;

  const GalleryImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    //_imageData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(formatImagename(imageUrl)),
        ),
        body: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          backgroundDecoration: BoxDecoration(color: Colors.white),
          gaplessPlayback: true,
          customSize: MediaQuery.of(context).size,
          enableRotation: false,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.8,
          initialScale: PhotoViewComputedScale.contained,
          basePosition: Alignment.center,
        ));
  }

  // extract the name from the image URL
  // example: https://files.brandtnerhof.at/wirtshoerner.jpg
  String formatImagename(String imageUrl) {
    final String name;
    String input = "???";

    final RegExp exp = RegExp(r'http.*\/([\w+_-]+)\.[\w+]{3,4}$');
    final RegExpMatch? match = exp.firstMatch(imageUrl);

    if (match != null) {
      input = match.group(1)!;
    }

    name = input[0].toUpperCase() +
        input.substring(1); // make first character uppercase
    return name;
  }
}
