import 'package:geolocator/geolocator.dart';

Future<Position> getUserPosition() async {
  try {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      throw ("Para o correto funcionamento do aplicativo é necessário que sua localização esteja habilitada!");
    }

    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        throw ("Para o correto funcionamento do aplicativo é necessário que sua localização esteja habilitada!");
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      throw ("Acesse as configurações para habilitar a localização!");
    }

    return Geolocator.getCurrentPosition();
  } catch (error) {
    return Position(
        longitude: -47.9292,
        latitude: -15.7801,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0);
  }
}
