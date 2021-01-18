// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NGOs _$NGOsFromJson(Map<String, dynamic> json) {
  return NGOs(
    position: json['position'] as List,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$NGOsToJson(NGOs instance) => <String, dynamic>{
      'title': instance.title,
      'position': instance.position,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
    results: (json['results'] as List)
        ?.map(
            (e) => e == null ? null : NGOs.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'results': instance.results,
    };
