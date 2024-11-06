import 'package:adhan_dart/adhan_dart.dart';

PrayerTimes getAdhan(double lat, double lon) {
  Coordinates coordinates = Coordinates(lat, lon);

  // Parameters
  CalculationParameters params = CalculationMethod.muslimWorldLeague();
  params.madhab = Madhab.hanafi;

  PrayerTimes prayerTimes = PrayerTimes( 
    coordinates: coordinates,
    date : DateTime.now(),
    calculationParameters : params,
    precision: true
  );

  return prayerTimes;
}
