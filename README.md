# packup

Assists you in packing up your next trip.

### Build APK for production

- Add `prod.keystore` on `android/.signing/` folder
- Update `android/.signing/key.properties` file
- Run `flutter build appbundle`

### Run tests

- Generate mocks and object json serialization first: `flutter pub run build_runner build`
- Then run unit tests: `flutter test test --coverage`

### Playstore link

- https://play.google.com/store/apps/details?id=com.tcorner.packup