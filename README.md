# Din

This is a simple material UI Quran Reader.

🤟 Works on Android, iOS, Linux, Windows and Mac. Thank you Flutter 💖!

## Running the project

After cloning the project, change to this working directory and run :

```sh
flutter run
```

## TODO

- [ ] Find a designer
- [ ] Publish on PlayStore
- [ ] Publish on Flathub
- [ ] Publish on F-Droid
- [ ] Create website

## Features

- [x] Quran
- [ ] Hadith and Sunnah
- [ ] Multiple translations

## Customisation

- [ ] Arabic / English / Transliteration toggles
- [ ] Scroll Direction
- [ ] App colors and theme

## UI

| light                    | dark                          |
| ------------------------ | ----------------------------- |
| ![](./_assets/surah.jpg) | ![](./_assets/surah-dark.jpg) |

## Building

For minimal app bundle size :

```sh
 flutter build appbundle --target-platform android-arm,android-arm64
```

For minimal apk size :

```sh
flutter build apk --split-per-abi
```
