import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/theme/theme_constants.dart';

/// Widget, shows name and version of the app.
class AppInfoText extends StatelessWidget {
  /// Constructor for [AppInfoText].
  const AppInfoText({super.key});

  /// Gets app name and app version.
  Future<String> appInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appName = packageInfo.appName;
    final version = packageInfo.version;
    return '$appName : $version';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: appInfoPadding),
      child: Center(
          child: FutureBuilder<String>(
            future: appInfo(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('${context.l10n.error} ${snapshot.error}');
                }
                return Text(snapshot.data!, style: TextStyle(fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),);  // Display the version info
              } else {
                return const CircularProgressIndicator();  // Show a loader until the data is loaded
              }
            },
          ),
      ),
    );
  }
}
