class LocationPoint{
  final double lat;
  final double long;
  final String name;

  LocationPoint({
    required this.lat,
    required this.long,
    required this.name
  });

  @override
  String toString() {
    return "$name (lat: $lat, long: $long)";
  }
}