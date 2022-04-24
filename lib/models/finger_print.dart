import 'dart:convert';

class FingerPrint {
  String? direction;
  String? time;
  LocationData? location;
  FingerPrint({
    this.direction,
    this.time,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'direction': direction,
      'time': time,
      'location': location?.toMap(),
    };
  }

  factory FingerPrint.fromMap(Map<String, dynamic> map) {
    return FingerPrint(
      direction: map['direction'],
      time: map['time'] ?? '',
      location: LocationData.fromMap(map['location']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FingerPrint.fromJson(String source) =>
      FingerPrint.fromMap(json.decode(source));
}

class LocationData {
  double? long;
  double? lat;
  LocationData({
    this.long,
    this.lat,
  });

  Map<String, dynamic> toMap() {
    return {
      'long': long,
      'lat': lat,
    };
  }

  factory LocationData.fromMap(Map<String, dynamic> map) {
    return LocationData(
      long: map['long'],
      lat: map['lat'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationData.fromJson(String source) =>
      LocationData.fromMap(json.decode(source));
}
