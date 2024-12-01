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
          title: Text('_imageData.name'),
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
}
