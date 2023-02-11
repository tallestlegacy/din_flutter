import 'package:geolocator/geolocator.dart';
import "dart:math";

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.unableToDetermine) {
    permission = await Geolocator.requestPermission();
  }

  return await Geolocator.getCurrentPosition();
}

//-------------------------------- Qibla Calculation --------------------------------//
// 21.4225° N, 39.8262° E

double qLat = 21.4225;
double qLon = 39.8262;

radians(double num) => num * (pi / 180);
degrees(double num) => num * (180 / pi);

double getQiblaAngle(double lat, double lon) {
  return getOffsetFromNorth(lat, lon);
}

double getOffsetFromNorth(double currentLatitude, double currentLongitude) {
  double laRad = radians(currentLatitude);
  double loRad = radians(currentLongitude);

  double deLa = radians(qLat);
  double deLo = radians(qLon);

  var toDegrees = degrees(atan(sin(deLo - loRad) /
      ((cos(laRad) * tan(deLa)) - (sin(laRad) * cos(deLo - loRad)))));
  if (laRad > deLa) {
    if ((loRad > deLo || loRad < radians(-180.0) + deLo) &&
        toDegrees > 0.0 &&
        toDegrees <= 90.0) {
      toDegrees += 180.0;
    } else if (loRad <= deLo &&
        loRad >= radians(-180.0) + deLo &&
        toDegrees > -90.0 &&
        toDegrees < 0.0) {
      toDegrees += 180.0;
    }
  }
  if (laRad < deLa) {
    if ((loRad > deLo || loRad < radians(-180.0) + deLo) &&
        toDegrees > 0.0 &&
        toDegrees < 90.0) {
      toDegrees += 180.0;
    }
    if (loRad <= deLo &&
        loRad >= radians(-180.0) + deLo &&
        toDegrees > -90.0 &&
        toDegrees <= 0.0) {
      toDegrees += 180.0;
    }
  }
  return toDegrees;
}
