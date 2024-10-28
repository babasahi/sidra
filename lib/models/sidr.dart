import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class Sidr {
  final String id;
  final GeoPoint geoPoint;
  final String description;
  final String discoveredBy;
  final String discoveredOn;

  const Sidr({
    required this.id,
    required this.geoPoint,
    required this.description,
    required this.discoveredBy,
    required this.discoveredOn,
  });

  factory Sidr.fromJson(Map<String, dynamic> json) {
    return Sidr(
      id: json['id'],
      geoPoint:
          GeoPoint(latitude: json['latitude'], longitude: json['longitude']),
      description: json['description'],
      discoveredBy: json['discoveredBy'],
      discoveredOn: json['discoveredOn'],
    );
  }
}
