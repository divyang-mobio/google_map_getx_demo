class LocationData {
  int? id;
  double latitude;
  double longitude;

  LocationData({this.id, required this.latitude, required this.longitude});

  factory LocationData.fromMap(Map<String, dynamic> json) => LocationData(
      id: json['id'], latitude: json['latitude'], longitude: json["longitude"]);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}