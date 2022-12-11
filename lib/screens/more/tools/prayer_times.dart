import 'package:din/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '/widgets/theme_toggle_button.dart';
import '/utils/location.dart';
import '/utils/store.dart';

class PrayerTimes extends StatefulWidget {
  const PrayerTimes({super.key});

  @override
  State<PrayerTimes> createState() => _PrayerTimesState();
}

class _PrayerTimesState extends State<PrayerTimes> {
  final GlobalStoreController globalStoreController =
      Get.put(GlobalStoreController());

  initPrayerData() async {
    Position position = await determinePosition();
    globalStoreController.setLocation(position.latitude, position.longitude);

    var prayerTimes = await fetchPrayerTimes(
      globalStoreController.lat.value,
      globalStoreController.lon.value,
    );

    globalStoreController.setPrayerTimeForMonth(prayerTimes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prayer Times"),
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          IconButton(
            onPressed: initPrayerData,
            icon: const Icon(Icons.my_location),
          ),
          const ThemeToggleButton(),
        ],
      ),
      body: Obx(
        () => ListView(
          children: [
            Text("Lat ${globalStoreController.lat.value}"),
            Text("Lon ${globalStoreController.lon.value}"),
            if (globalStoreController.prayerTimes.isNotEmpty)
              Text(globalStoreController.prayerTimes["data"][0]["timings"]
                  .toString()),
          ],
        ),
      ),
    );
  }
}
