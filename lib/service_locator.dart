import 'package:get_it/get_it.dart';
import 'package:series_app/data/series_api/series_api.dart';
import 'package:series_app/features/home/home_controller.dart';

/// Depency injection locator. It is reponsible to provide the application the
/// correct depency, depending on the case.
///
/// E.g: For the running application, it provides the actual implementations,
/// while for the tests it provides a mock implementation.
final locator = GetIt.instance;

/// Setup the depency injection locator for the running application
void setupLocator() {
  // ***** Controllers *****
  locator.registerFactory<HomeController>(() => HomeController());

  // ***** APIs *****
  locator.registerFactory<SeriesApi>(() => SeriesApi());
}