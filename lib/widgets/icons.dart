import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Widget linkIcon = Icon(
  Icons.link_rounded,
  color: Colors.grey,
  size: 16,
);
const Widget copyIcon = Icon(
  Icons.copy_rounded,
  color: Colors.grey,
  size: 16,
);
const Widget shareIcon = Icon(
  Icons.share_rounded,
  color: Colors.grey,
  size: 16,
);
const Widget favouriteIcon = Icon(
  Icons.favorite_rounded,
  color: Colors.grey,
  size: 16,
);

class DinAppIcon extends StatelessWidget {
  final double size;
  const DinAppIcon({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Material(
        shape: const CircleBorder(),
        elevation: 2,
        child: SvgPicture.asset(
          "assets/svg/din.svg",
          color: Theme.of(context).colorScheme.secondary,
          width: size,
        ),
      ),
    );
  }
}
