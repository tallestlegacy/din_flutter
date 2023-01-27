// ignore_for_file: unused_import, prefer_const_constructors_in_immutables

import 'dart:async';
import 'dart:math';

import 'package:din/screens/more/tools/prayer_times.dart';
import 'package:din/utils/adhan.dart';
import 'package:din/widgets/back_button.dart';
import 'package:din/widgets/theme_toggle_action.dart';
import 'package:flutter/foundation.dart';
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

class _QiblaState extends State<Qibla> with TickerProviderStateMixin {
  final GlobalStoreController globalStoreController =
      Get.put(GlobalStoreController());
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  bool loading = false;

  setLocation(BuildContext context) async {
    if (loading) return;
    setState(() {
      loading = true;
    });

    String msg = await globalStoreController.setLocation();

    setState(() {
      loading = false;
    });

    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(content: Text(msg)));
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
    _controller.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  double get compassAngle {
    if (x == 0) {
      if (y > 0) return 0;
      return pi;
    }

    double tangent = atan2(y, x);
    //double theta = -((tangent) - pi / 2) % (pi * 2);
    //return theta >= pi ? theta - (2 * pi) : theta;

    return -((tangent) - pi / 2) % (pi * 2);
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
          const ThemeToggleAction(),
        ],
      ),
      body: Obx(
        () => Container(
          child: !globalStoreController.locationInitialised.value
              ? const Center(
                  child: Text(
                    "Enable location services then click the 'add location' icon button.",
                    textAlign: TextAlign.center,
                  ),
                )
              : SafeArea(
                  bottom: true,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
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
                            title: const Text("Angle relative to Qibla"),
                            subtitle: Text("${getQiblaAngle(
                              globalStoreController.lat.value,
                              globalStoreController.lon.value,
                            ).toPrecision(2)}º"),
                          ),
                          if (kDebugMode)
                            ListTile(
                              enabled: false,
                              title: const Text("Angle relative to Qibla"),
                              subtitle: Text("$x, $y, $z}º"),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Material(
                          shape: const CircleBorder(),
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withAlpha(10),
                          shadowColor: Colors.grey.withAlpha(300),
                          elevation: 1,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Image.asset("assets/png/top.png"),
                              AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) => RotationTransition(
                                  turns: AlwaysStoppedAnimation(
                                      compassAngle / (pi * 2)),
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
                                              .secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
