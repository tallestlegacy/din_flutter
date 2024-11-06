import 'package:din/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ScrollToHide extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;

  const ScrollToHide({
    super.key,
    required this.controller,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<ScrollToHide> createState() => _ScrollToHideState();
}

class _ScrollToHideState extends State<ScrollToHide> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(listen);
  }

  void listen() {
    final direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      setState(() {
        isVisible = true;
      });
    } else if (direction == ScrollDirection.reverse) {
      setState(() {
        isVisible = false;
      });
    }
  }

  final GlobalStoreController globalStoreController =
      Get.put(GlobalStoreController());

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: true,
        child: Obx(
          () => AnimatedContainer(
            duration: widget.duration,
            height: (isVisible && !globalStoreController.drawerIsOpen.value)
                ? 72
                : 0,
            child: Wrap(
              children: [widget.child],
            ),
          ),
        ),
      );
}
