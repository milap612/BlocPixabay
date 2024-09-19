

import '../data/mdel/image_model.dart';

abstract class GalleryState {}

class GalleryLoading extends GalleryState {}

class GalleryLoaded extends GalleryState {
  final List<ImageModel> images;
  final bool hasReachedMax;

  GalleryLoaded({required this.images, required this.hasReachedMax});

}

class GalleryError extends GalleryState {
  final String message;

  GalleryError({required this.message});

}
