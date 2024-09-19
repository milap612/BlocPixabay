import '../api/pixabay_api.dart';
import '../mdel/image_model.dart';

class ImageRepository {
  final PixabayApi api;

  ImageRepository(this.api);

  Future<List<ImageModel>> fetchImages(String query, int page) async {
    final response = await api.getImages(
      apiKey: '45978526-6ae24158928b7744fb53b2b2d', // Replace with your Pixabay API Key
      query: query,
      page: page,
    );
    return response.hits;
  }
}
