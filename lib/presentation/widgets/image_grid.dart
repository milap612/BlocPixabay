import 'package:flutter/material.dart';

import '../../data/mdel/image_model.dart';

class ImageGrid extends StatelessWidget {
  final List<ImageModel> images;
  final void Function(ImageModel image) onImageTapped;
  final ScrollController scrollController;

  const ImageGrid(
      {super.key,
      required this.images,
      required this.onImageTapped,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      int columns = (constraints.maxWidth ~/ 150).toInt();
      return GridView.builder(
        controller: scrollController,
        itemCount: images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final image = images[index];
          return GestureDetector(
            onTap: () => onImageTapped(image),
            child: Column(
              children: [
                Hero(
                  tag: image.id,
                  child: Image.network(image.webformatURL,
                      height: 100, width: 100, fit: BoxFit.cover),
                ),
                Text('${image.likes} likes \n ${image.views} views'),
              ],
            ),
          );
        },
      );
    });
  }
}
