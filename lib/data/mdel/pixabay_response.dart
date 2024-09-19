import 'package:json_annotation/json_annotation.dart';

import 'image_model.dart';

part 'pixabay_response.g.dart';

@JsonSerializable()
class PixabayResponse {
  final int total;
  final int totalHits;
  final List<ImageModel> hits;

  PixabayResponse({required this.total, required this.totalHits, required this.hits});

  factory PixabayResponse.fromJson(Map<String, dynamic> json) =>
      _$PixabayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PixabayResponseToJson(this);
}