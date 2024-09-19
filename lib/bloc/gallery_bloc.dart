import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/mdel/image_model.dart';
import '../data/repository/image_repository.dart';
import 'gallery_event.dart';
import 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final ImageRepository repository;
  List<ImageModel> images = [];

  GalleryBloc({required this.repository}) : super(GalleryLoading()) {
    on<FetchImages>(_onFetchImages);
  }

  Future<void> _onFetchImages(
      FetchImages event, Emitter<GalleryState> emit) async {
    if (event.page == 1) {
      emit(GalleryLoading());
    }
    try {
      final newImages = await repository.fetchImages(event.query, event.page);

      if (event.page == 1) {
        // If it's the first page, reset the images
        images = newImages;
      } else {
        // Append new images to the existing list for pagination
        images.addAll(newImages);
      }

      emit(GalleryLoaded(images: images, hasReachedMax: images.isEmpty));
    } catch (e) {
      emit(GalleryError(message: e.toString()));
    }
  }
}
