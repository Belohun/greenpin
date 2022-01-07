# Greenpin mobile app

This is repository for mobile app development.

## Technology

- [Flutter](https://flutter.dev/) [2.8.0](https://flutter.dev/docs/development/tools/sdk/releases) ([FVM](https://fvm.app/) recommended)

## Set up
####If FVM is used, add "fvm" before every command

- Get packages - flutter pub get
- Build generated code - flutter pub run build_runner build
- Generate translated keys - fvm flutter pub run easy_localization:generate --source-dir ./assets/translations -f keys -o local_keys.g.dart

## Run

- Development - flutter run --flavor dev lib/main_dev.dart
- Production - flutter run --flavor prod lib/main_prod.dart
