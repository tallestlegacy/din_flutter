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
  double la_rad = radians(currentLatitude);
  double lo_rad = radians(currentLongitude);

  double de_la = radians(qLat);
  double de_lo = radians(qLon);

  var toDegrees = degrees(atan(sin(de_lo - lo_rad) /
      ((cos(la_rad) * tan(de_la)) - (sin(la_rad) * cos(de_lo - lo_rad)))));
  if (la_rad > de_la) {
    if ((lo_rad > de_lo || lo_rad < radians(-180.0) + de_lo) &&
        toDegrees > 0.0 &&
        toDegrees <= 90.0) {
      toDegrees += 180.0;
    } else if (lo_rad <= de_lo &&
        lo_rad >= radians(-180.0) + de_lo &&
        toDegrees > -90.0 &&
        toDegrees < 0.0) {
      toDegrees += 180.0;
    }
  }
  if (la_rad < de_la) {
    if ((lo_rad > de_lo || lo_rad < radians(-180.0) + de_lo) &&
        toDegrees > 0.0 &&
        toDegrees < 90.0) {
      toDegrees += 180.0;
    }
    if (lo_rad <= de_lo &&
        lo_rad >= radians(-180.0) + de_lo &&
        toDegrees > -90.0 &&
        toDegrees <= 0.0) {
      toDegrees += 180.0;
    }
  }
  return toDegrees;
}
