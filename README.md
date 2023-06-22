# Din

This is a simple material UI Quran and Sunnah reader.

🤟 Works on Android, iOS, Linux, Windows and Mac. Thank you Flutter 💖!

[https://play.google.com/store/apps/details?id=com.tallestlegacy.din_dt]

## Running the project

After cloning the project, change to this working directory and run :

```sh
flutter run
```

## TODO

- [ ] Find a designer
- [x] Publish on PlayStore

## Features

- [x] Quran
- [x] Quran Recitations
- [ ] Dua Recitations
- [x] Hadith and Sunnah
- [ ] Madrasa
- [x] Multiple translations
- [ ] Abridged explanations of the Quran
- [ ] Learning resources
- [x] Favourites
- [ ] Application reviews and Release notes
- [ ] User manual

- [x] Text sharing
- [ ] Search quran
- [ ] Search every other list
- [ ] Islamic calendar
- [ ] Optional reminders (Prayer and Fasting)

## Customisation

- [x] Arabic / English / Transliteration toggles
- [x] Scroll Direction
- [x] App colors and theme
- [x] Arabic fonts
- [ ] Other UI fonts

## UI

| light                    | dark                          |
| ------------------------ | ----------------------------- |
| ![image](https://github.com/tallestlegacy/din_flutter/assets/71118951/32186746-7022-470d-adcc-032b9c28a475) | ![image](https://github.com/tallestlegacy/din_flutter/assets/71118951/d2f95ee9-65ce-4578-adc3-5817a18693b2) |

## Building

For minimal app bundle size :

```sh
 flutter build appbundle --build-number <n> # support more platforms
 flutter build appbundle --target-platform android-arm,android-arm64 --build-number <n>
```

For minimal apk size :

```sh
flutter build apk --split-per-abi
```
