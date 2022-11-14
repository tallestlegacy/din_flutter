import 'dart:math';

String toFarsi(int i) {
  const farsi = "۰۱٢٣٤٥٦٧٨٩";
  String numStr = i.toString();

  for (int i = 0; i < farsi.length; i++) {
    numStr = numStr.replaceAll(i.toString(), farsi[i]);
  }

  return numStr;
}
