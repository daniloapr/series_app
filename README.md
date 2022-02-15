# Series App

The main purpose of this project is to test what kind of solutions I can give to certain day-to-day tasks and how well I can accomplish good practices.

## 🔥 Run

1. Install [Flutter](https://flutter.dev)
2. Clone this repository: `git clone git@github.com:daniloapr/series_app.git`
3. Access the project's folder: `cd path/series_app`
4. Run `flutter pub get` to install dependencies
5. Run `flutter run` for debug mode or `flutter run --release`

This project was developed with Flutter `2.8.1` stable channel.

There is also an `apk` file in the root of the project. You can use it to install a release mode app directly in your Android device.

## 📱 Working Devices

This project works for:

- Android
- iOS

It also runs on MacOS and Web (Chrome) but it's not optimized.

## 🔨 Features

### Major

- Fetch tv shows from the [TV Maze API](https://www.tvmaze.com/api)
- Search tv shows by name
- Open tv show details screen
- List episodes by season
- Show episodes details in a expandable card

### Minor

These are the features behind the scenes:

- Cache downloaded images, showing them faster for the second time
- Apply debouncing and cancelation on `search` calls, to improve the user's experience
- Handle all `Loading` and `Error` states when fetching lists and images.
- Show image placeholder when not provided.
- Use [GetIt](https://pub.dev/packages/get_it) for dependency injection to allow better testing
- Show summary texts with [flutter_html](https://github.com/daniloapr/flutter_html) to handle the html tags

## 🐛 Test

This project contain the following test examples:

- Unit test
- Controller test
- Widget test

This proves that the chosen architecture is testable, however, the test coverage is low due to the short spare time I had to make the project.

## 📖 References

- [TV Maze API](https://www.tvmaze.com/api)
- [TV icon created by Freepik - Flaticon](https://www.flaticon.com/free-icons/tv)

## 📸 Screenshots

![series 01](https://user-images.githubusercontent.com/31525418/153972852-afe931d2-cb37-4f15-8fcd-cc399126babf.jpeg)
![series 02](https://user-images.githubusercontent.com/31525418/153972861-18cbfda2-e37c-47d5-829e-861aad9698f1.jpeg)
![series 03](https://user-images.githubusercontent.com/31525418/153972871-c931befc-4f7a-4871-9f05-d8c860d17556.jpeg)
![series 04](https://user-images.githubusercontent.com/31525418/153972877-87082293-7e2b-45aa-bf32-0a5023dbe72a.jpeg)

