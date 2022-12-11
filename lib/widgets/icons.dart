import 'package:flutter/material.dart';

import '/constants/strings.dart';

const Widget linkIcon = Icon(
  Icons.link_rounded,
  color: Colors.grey,
  size: 16,
);

Widget dinAppIcon = Container(
  decoration: const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(100)),
  ),
  child: Text(din),
);
