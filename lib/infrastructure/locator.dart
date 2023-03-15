import 'package:get_it/get_it.dart';

import '../application/firebase_analytics.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AnalyticsService());
}
