import 'package:get_it/get_it.dart';

import '../data/datasources/work_data_source.dart';
import '../data/repositories/settings_repository.dart';
import 'database/database_operations.dart';

/// Function, where we setup GetIt service locators.
Future<void> setUpServicesLocator() async {
  final db = await DatabaseOperations.openAppDatabaseAndCreateTables('piececalc');
  GetIt.instance
    // Settings related services.
    ..registerLazySingleton<SettingsRepository>(SettingsRepository.new)
    // User data related services.
    ..registerLazySingleton<WorkDataSource>(() => WorkDataSource(db));
}
