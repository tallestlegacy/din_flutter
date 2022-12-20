import 'package:din/constants/strings.dart';
import 'package:din/utils/network.dart';
import 'package:flutter/material.dart';
import "package:geolocator/geolocator.dart";
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
  bool loading = false;
  int day = 0;

  final GlobalStoreController globalStoreController =
      Get.put(GlobalStoreController());

  setLocation() async {
    Position position = await determinePosition();
    globalStoreController.setLocation(position.latitude, position.longitude);
  }

  setPrayerTimes() async {
    var prayerTimes = await fetchPrayerTimes(
      globalStoreController.lat.value,
      globalStoreController.lon.value,
    );
    globalStoreController.setPrayerTimeForMonth(prayerTimes);
  }

  initPrayerData() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }

    await setLocation();
    await setPrayerTimes();

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    if (mounted) {
      setState(() {
        day = date.day - 1;
      });
    }
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
            icon: const Icon(Icons.my_location_rounded),
          ),
          const ThemeToggleButton(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await setPrayerTimes();
        },
        child: Obx(
          () => globalStoreController.prayerTimes.isNotEmpty
              ? ListView(
                  children: [
                    if (loading) const LinearProgressIndicator(),
                    for (var time in prayers)
                      ListTile(
                          enabled: false,
                          title: Text(time),
                          subtitle: Text(globalStoreController
                              .prayerTimes["data"][0]["timings"][time])),
                    const Divider(),
                    ListTile(
                      enabled: false,
                      leading: const Icon(Icons.calendar_month_rounded),
                      title: Text(
                        "${globalStoreController.prayerTimes["data"][day]["date"]["hijri"]["weekday"]["ar"]}, "
                        "${globalStoreController.prayerTimes["data"][day]["date"]["hijri"]["month"]["ar"]} "
                        "${globalStoreController.prayerTimes["data"][day]["date"]["hijri"]["year"]}",
                      ),
                      subtitle: Text(
                        "${globalStoreController.prayerTimes["data"][day]["date"]["gregorian"]["weekday"]["en"]}, "
                        "${day + 1} "
                        "${globalStoreController.prayerTimes["data"][day]["date"]["gregorian"]["month"]["en"]} "
                        "${globalStoreController.prayerTimes["data"][day]["date"]["gregorian"]["year"]}",
                      ),
                    ),
                    ListTile(
                      enabled: false,
                      leading: const Icon(Icons.public),
                      title: Text(
                          "${globalStoreController.prayerTimes["data"][0]["meta"]["timezone"]}"),
                      subtitle: Text(
                          "(${globalStoreController.lat.value}, ${globalStoreController.lon.value})"),
                    ),
                  ],
                )
              : Center(
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Padding(
                          padding: EdgeInsets.all(32),
                          child: Text(
                            "Turn network and location services on temporarily then click the target button.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
        ),
      ),
    );
  }
}
