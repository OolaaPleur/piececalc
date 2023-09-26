import 'package:flutter/material.dart';

import 'app/app.dart';
import 'bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap(() => const App());
}
