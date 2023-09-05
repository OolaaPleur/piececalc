import 'package:flutter/material.dart';

import 'app/app.dart';
import 'bootstrap.dart';
import 'utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpServicesLocator();
  await bootstrap(() => const App());
}
