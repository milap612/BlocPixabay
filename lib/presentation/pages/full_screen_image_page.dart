import 'package:flutter/material.dart';
import '../../data/mdel/image_model.dart';

class FullScreenImagePage extends StatelessWidget {
  final ImageModel image;

  const FullScreenImagePage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child: Hero(
            tag: image.id,
            child: Image.network(image.largeImageURL),
          ),
        ),
      ),
    );
  }
}
