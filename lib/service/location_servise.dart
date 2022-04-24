import 'package:attendance_app/models/location_data.dart';
import 'package:geolocator/geolocator.dart';

Future<LocationData2?> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  LocationData2? locationData = LocationData2();

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // return Future.error('Location services are disabled.');
    locationData.isGetData = false;
    return locationData;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      locationData.isGetData = false;
      return locationData;
      //TODO: Location
    }
  }

  if (permission == LocationPermission.deniedForever) {
    locationData.isGetData = false;
    return locationData;
    // return Future.error(
    //     'Location permissions are permanently denied, we cannot request permissions.');
  }

  Position position = await Geolocator.getCurrentPosition();
  locationData.isGetData = true;
  locationData.lat = position.latitude;
  locationData.long = position.longitude;

  return locationData;
}
