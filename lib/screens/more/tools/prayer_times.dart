import 'package:adhan_dart/adhan_dart.dart';
import 'package:din/utils/adhan.dart';
import 'package:din/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/theme_toggle_action.dart';
import '/utils/store.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  bool loading = false;

  final GlobalStoreController globalStoreController =
      Get.put(GlobalStoreController());

  initPrayerData() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }

    String msg = await globalStoreController.setLocation();

    setState(() {
      loading = false;
    });

    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(content: Text(msg)));
  }

  List get adhanList {
    PrayerTimes prayerTimes = getAdhan(
        globalStoreController.lat.value, globalStoreController.lon.value);

    List adhan = [
      {"title": "Fajr", "time": prayerTimes.fajr},
      {"title": "Fajr After", "time": prayerTimes.fajrafter},
      {"title": "Dhuhr", "time": prayerTimes.dhuhr},
      {"title": "Asr", "time": prayerTimes.asr},
      {"title": "Maghrib", "time": prayerTimes.maghrib},
      {"title": "Isha Before", "time": prayerTimes.ishabefore},
      {"title": "Isha", "time": prayerTimes.isha},
    ];

    return adhan;
  }

  String timeFormat(DateTime dateTime) {
    return TimeOfDay.fromDateTime(dateTime.toLocal()).format(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Prayer Times"),
        //backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () => initPrayerData(),
              icon: loading
                  ? const Icon(Icons.location_searching_rounded)
                  : globalStoreController.locationInitialised.value
                      ? const Icon(Icons.my_location_rounded)
                      : const Icon(Icons.add_location_alt_rounded),
            ),
          ),
          const ThemeToggleAction(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => initPrayerData(),
        child: Obx(
          () => loading
              ? const LinearProgressIndicator()
              : globalStoreController.locationInitialised.value
                  ? ListView(children: [
                      for (var prayer in adhanList)
                        ListTile(
                          enabled: false,
                          title: Text(prayer["title"]),
                          subtitle: Text(
                            timeFormat(prayer["time"]),
                          ),
                        ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.calendar_today_rounded),
                        enabled: false,
                        title: Text(
                          DateFormat("EEEE d MMMM, yyyy")
                              .format(DateTime.now())
                              .toString(),
                        ),
                      )
                    ])
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Text(
                          "Turn location services on temporarily then click the target button.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
