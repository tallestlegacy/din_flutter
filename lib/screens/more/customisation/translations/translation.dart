import '/utils/network.dart';
import '/utils/store.dart';
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

  // helpful getters
  get isNotDownloaded => _state == "not_downloaded";
  get isDownloading => _state == "downloading";
  get isDownloaded => translationsStoreController.editionIsDownloaded(
      widget.language, widget.edition);
  get isDownloadFailure => _state == "download_failure";
  get isDefault =>
      translationsStoreController.defaultTranslation["language"] ==
          widget.language &&
      translationsStoreController.defaultTranslation["edition"] ==
          widget.edition;

  void handleTap() {
    if (isDownloaded) {
      makeDefault();
    } else {
      download();
    }
  }

  Future<void> download() async {
    if (isDownloading) return;

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

        final scaffold = ScaffoldMessenger.of(context);
        scaffold.showSnackBar(
          SnackBar(
            content: Text(
                '${widget.edition} downloaded successfully. Do you want this as your new default?'),
            action: SnackBarAction(
                label: 'OK',
                onPressed: () {
                  translationsStoreController.setTranslation({
                    "edition": widget.edition.toString(),
                    "language": widget.language.toString(),
                  });
                  scaffold.hideCurrentSnackBar();
                }),
          ),
        );
      }
    } else {
      if (mounted) {
        setState(() {
          _state = "download_failure";
        });
      }
    }
  }

  void makeDefault() {
    translationsStoreController.setTranslation({
      "language": widget.language,
      "edition": widget.edition,
    });

    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text('${widget.edition} is now the default translation'),
      ),
    );
  }

  void delete() async {
    await translationsStoreController.deleteEdition(
        widget.language, widget.edition);

    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text('Deleted ${widget.edition} from local storage'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        onTap: handleTap,
        enabled: !isDownloading,
        title: Text(widget.edition),
        subtitle: isDefault ? const Text("Default") : null,
        leading: Icon(() {
          if (isDownloading) return Icons.downloading_rounded;
          if (translationsStoreController.editionIsDownloaded(
              widget.language, widget.edition)) {
            return Icons.download_done_rounded;
          }
          return Icons.download_rounded;
        }()),
        trailing: isDownloaded
            ? PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: makeDefault,
                    child: const Text("Make Default"),
                  ),
                  PopupMenuItem(
                    onTap: download,
                    child: const Text("Redownload"),
                  ),
                  PopupMenuItem(
                    enabled: !isDefault,
                    onTap: delete,
                    child: const Text("Delete"),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}

class TranslationRadio extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final translation;
  TranslationRadio({super.key, required this.translation});

  final TranslationsStoreController translationsStoreController =
      Get.put(TranslationsStoreController());

  @override
  Widget build(BuildContext context) {
    var t = {
      "edition": translation["edition"].toString(),
      "language": translation["language"].toString(),
    };
    return Obx(
      () => RadioListTile(
        controlAffinity: ListTileControlAffinity.trailing,
        activeColor: Theme.of(context).colorScheme.primary,
        value: "${t["language"]}-${t["edition"]}",
        groupValue:
            "${translationsStoreController.defaultTranslation["language"]}-${translationsStoreController.defaultTranslation["edition"]}",
        selected:
            "${translationsStoreController.defaultTranslation["language"]}-${translationsStoreController.defaultTranslation["edition"]}" ==
                "${t["language"]}-${t["edition"]}",
        onChanged: (value) {
          translationsStoreController.setTranslation(t);
        },
        title: Text(translation["edition"]),
        subtitle: Text(translation["language"]),
      ),
    );
  }
}
