import 'dart:async';
import 'dart:math';

import 'package:din/widgets/back_button.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '/utils/location.dart';
import '/utils/store.dart';

class Qibla extends StatefulWidget {
  Qibla({super.key});

  @override
  State<Qibla> createState() => _QiblaState();
}

class _QiblaState extends State<Qibla> {
  final GlobalStoreController globalStoreController =
      Get.put(GlobalStoreController());
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  bool loading = false;

  setLocation(BuildContext context) async {
    if (loading) return;
    setState(() {
      loading = true;
    });
    Position position = await determinePosition();
    globalStoreController.setLocation(position.latitude, position.longitude);
    setState(() {
      loading = false;
    });

    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        content: Text('Location confirmed.'),
      ),
    );
  }

  // orientation
  double x = 0;
  double y = 0;
  double z = 0;

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      magnetometerEvents.listen((MagnetometerEvent event) {
        if (mounted) {
          setState(() {
            x = event.x;
            y = event.y;
            z = event.z;
          });
        }
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  double get compassAngle {
    if (x == 0) {
      if (y > 0) return 0;
      return pi;
    }

    double tangent = atan2(y, x);

    return (tangent - pi / 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Qibla"),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () => setLocation(context),
              icon: loading
                  ? const Icon(Icons.location_searching_rounded)
                  : globalStoreController.locationInitialised.value
                      ? const Icon(Icons.my_location_rounded)
                      : const Icon(Icons.add_location_alt_rounded),
            ),
          ),
          const ThemeToggleButton(),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Center(
            child: !globalStoreController.locationInitialised.value
                ? const Text(
                    "Enable location services then click the 'add location' icon button.",
                    textAlign: TextAlign.center,
                  )
                : Wrap(
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      Material(
                        shape: const CircleBorder(),
                        shadowColor: Colors.grey.withAlpha(300),
                        elevation: 1,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Image.asset("assets/png/top.png"),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              child: Transform.rotate(
                                angle: compassAngle,
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/compass.svg",
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                    Transform.rotate(
                                      angle: (pi / 180) *
                                          getQiblaAngle(
                                            globalStoreController.lat.value,
                                            globalStoreController.lon.value,
                                          ),
                                      child: SvgPicture.asset(
                                        "assets/svg/needle.svg",
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ListTile(
                            enabled: false,
                            title: const Text("Current Location"),
                            subtitle: Text(
                                "lat : ${globalStoreController.lat.value}º     "
                                "lon : ${globalStoreController.lon.value}º"),
                          ),
                          ListTile(
                            enabled: false,
                            title: const Text("Relative Angle"),
                            subtitle: Text("${getQiblaAngle(
                              globalStoreController.lat.value,
                              globalStoreController.lon.value,
                            )}º"),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
