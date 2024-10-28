class Sidr {
  final String id;
  final double latitude;
  final double longitude;
  final String description;
  final String discoveredBy;
  final String discoveredOn;

  const Sidr({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.discoveredBy,
    required this.discoveredOn,
  });

  factory Sidr.fromJson(Map<String, dynamic> json) {
    return Sidr(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      discoveredBy: json['discoveredBy'],
      discoveredOn: json['discoveredOn'],
    );
  }
}
