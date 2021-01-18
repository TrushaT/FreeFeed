import 'dart:convert';
import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

part 'locations.g.dart';



@JsonSerializable()
class  NGOs {
  NGOs({
    this.position,
    this.title,
  });

  factory NGOs.fromJson(Map<String, dynamic> json) => _$NGOsFromJson(json);
  Map<String, dynamic> toJson() => _$NGOsToJson(this);

  
  final String title;
  final List position;
}

@JsonSerializable()
class Locations {
  Locations({
    this.results,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<NGOs> results;
}

Future<Locations> getLocations() async {
  var googleLocationsURL = await rootBundle.loadString('assets/locations.json');
  return Locations.fromJson(json.decode(googleLocationsURL));
}
