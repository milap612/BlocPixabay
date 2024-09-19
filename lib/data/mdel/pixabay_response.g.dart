// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pixabay_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PixabayResponse _$PixabayResponseFromJson(Map<String, dynamic> json) =>
    PixabayResponse(
      total: (json['total'] as num).toInt(),
      totalHits: (json['totalHits'] as num).toInt(),
      hits: (json['hits'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PixabayResponseToJson(PixabayResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'totalHits': instance.totalHits,
      'hits': instance.hits,
    };
