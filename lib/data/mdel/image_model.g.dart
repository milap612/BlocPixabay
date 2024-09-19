// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      id: (json['id'] as num).toInt(),
      webformatURL: json['webformatURL'] as String,
      largeImageURL: json['largeImageURL'] as String,
      likes: (json['likes'] as num).toInt(),
      views: (json['views'] as num).toInt(),
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'webformatURL': instance.webformatURL,
      'largeImageURL': instance.largeImageURL,
      'likes': instance.likes,
      'views': instance.views,
    };
