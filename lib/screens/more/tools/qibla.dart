import 'dart:math';

import 'package:din/widgets/back_button.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';

import '/utils/location.dart';
import '/utils/store.dart';

class Qibla extends StatelessWidget {
  Qibla({super.key});

  final GlobalStoreController globalStoreController =
      Get.put(GlobalStoreController());

  setLocation(BuildContext context) async {
    Position position = await determinePosition();
    globalStoreController.setLocation(position.latitude, position.longitude);

    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        content: Text('Location confirmed.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Qibla"),
        actions: [
          IconButton(
            onPressed: () => setLocation(context),
            icon: const Icon(Icons.my_location_rounded),
          ),
          const ThemeToggleButton(),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: globalStoreController.lat == null
              ? const Text(
                  "Enable location services then click the target icon",
                )
              : Obx(
                  () => Wrap(
                    runSpacing: 64,
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      Material(
                        shape: const CircleBorder(),
                        shadowColor: Colors.grey.withAlpha(100),
                        elevation: 1,
                        child: SmoothCompass(
                          compassAsset: Stack(
                            children: [
                              Image.asset("assets/png/ticks.png"),
                              Transform.rotate(
                                angle: (pi / 180) *
                                    getQiblaAngle(
                                      globalStoreController.lat.value,
                                      globalStoreController.lon.value,
                                    ),
                                child: Image.asset("assets/png/pick.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          ListTile(
                            title: const Text("Current Coordinates"),
                            subtitle: Text(
                                "lat : ${globalStoreController.lat.value}º     "
                                "lon : ${globalStoreController.lon.value}º"),
                          ),
                          ListTile(
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
