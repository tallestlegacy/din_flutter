import 'package:adhan_dart/adhan_dart.dart';

PrayerTimes getAdhan(double lat, double lon) {
  Coordinates coordinates = Coordinates(lat, lon);

  // Parameters
  CalculationParameters params = CalculationMethod.MuslimWorldLeague();
  params.madhab = Madhab.Hanafi;

  PrayerTimes prayerTimes = PrayerTimes(
    coordinates,
    DateTime.now(),
    params,
    precision: true,
  );

  return prayerTimes;
}
