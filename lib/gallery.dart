import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:brandtnerhof/galleryimage.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  List<String> imageUrls = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchImageUrls();
  }

  Future<void> fetchImageUrls() async {
    try {
      final response =
          await http.get(Uri.parse('https://files.brandtnerhof.at/'));
      if (response.statusCode == 200) {
        // Parse HTML for image links (adjust parsing based on actual structure)
        final regex = RegExp(r'href="([^"]*\.(jpg|jpeg|png|gif))"');
        final matches = regex.allMatches(response.body);
        setState(() {
          imageUrls = matches
              .map((m) => 'https://files.brandtnerhof.at/${m.group(1)}')
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load images');
      }
    } catch (e) {
      print('Error fetching images: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : imageUrls.isEmpty
              ? Center(child: Text('No images found'))
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    final imageUrl = imageUrls[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GalleryImage(imageUrl: imageUrl),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
    );
  }
}
