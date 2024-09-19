import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../mdel/pixabay_response.dart';

part 'pixabay_api.g.dart';

@RestApi(baseUrl: "https://pixabay.com/api/")
abstract class PixabayApi {
  factory PixabayApi(Dio dio, {String baseUrl}) = _PixabayApi;

  @GET("/")
  Future<PixabayResponse> getImages({
    @Query("key") required String apiKey,
    @Query("q") required String query,
    @Query("page") required int page,
    @Query("image_type") String imageType = "photo",
    @Query("per_page") int perPage = 20,
  });
}


