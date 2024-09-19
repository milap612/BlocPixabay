

abstract class GalleryEvent {}

class FetchImages extends GalleryEvent {
  final String query;
  final int page;

  FetchImages({required this.query, required this.page});
}
