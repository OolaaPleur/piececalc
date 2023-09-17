import 'package:flutter/material.dart';
import 'package:piececalc/utils/database/populate_test_data.dart';

import 'app/app.dart';
import 'bootstrap.dart';
import 'utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpServicesLocator();

  await PopulateTestData().populateTestData();

  await bootstrap(() => const App());
}
