import 'package:din/util/network.dart';
import 'package:din/util/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Translation extends StatefulWidget {
  final String language;
  final String edition;
  const Translation({super.key, required this.language, required this.edition});

  @override
  State<Translation> createState() => _TranslationState();
}

class _TranslationState extends State<Translation> {
  String _state = "not_downloaded";
  final TranslationsStoreController translationsStoreController =
      Get.put(TranslationsStoreController());

  @override
  initState() {
    super.initState();

    if (translationsStoreController.downloadedQuranEditions
        .contains({"language": widget.language, "edition": widget.edition})) {
      if (mounted) {
        setState(() {
          _state = "downloaded";
        });
      }
    }
  }

  void handleTap() {
    if (_state == "downloaded") {
      translationsStoreController.setTranslation({
        "language": widget.language,
        "edition": widget.edition,
      });
    } else {
      download();
    }
  }

  Future<void> download() async {
    if (_state == "downloading") return;

    if (mounted) {
      setState(() {
        _state = "downloading";
      });
    }
    var data = await fetchEdition(widget.language, widget.edition);

    if (data.isNotEmpty) {
      translationsStoreController.saveEdition(
          widget.language, widget.edition, data);

      if (mounted) {
        setState(() {
          _state = "downloaded";
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _state = "download_failure";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        leading: const Icon(Icons.translate_rounded),
        onTap: handleTap,
        onLongPress: download,
        title: Text(widget.edition),
        trailing: Icon(() {
          switch (_state) {
            case "downloading":
              return Icons.downloading_rounded;
            case "downloaded":
              return Icons.download_done;
          }
          if (translationsStoreController.editionIsDownloaded(
              widget.language, widget.edition)) {
            return Icons.download_done_rounded;
          }
          return Icons.download_rounded;
        }()),
      ),
    );
  }
}

class TranslationRadio extends StatelessWidget {
  final translation;
  TranslationRadio({super.key, required this.translation});

  final TranslationsStoreController translationsStoreController =
      Get.put(TranslationsStoreController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RadioListTile(
        value: translation,
        groupValue: translationsStoreController.defaultTranslation,
        selected: translationsStoreController.defaultTranslation["edition"] ==
                translation["edition"] &&
            translationsStoreController.defaultTranslation["language"] ==
                translation["language"],
        onChanged: (value) {
          translationsStoreController.setTranslation({
            "edition": translation["edition"].toString(),
            "language": translation["language"].toString(),
          });
        },
        title: Text(translation["edition"]),
        subtitle: Text(translation["language"]),
      ),
    );
  }
}
