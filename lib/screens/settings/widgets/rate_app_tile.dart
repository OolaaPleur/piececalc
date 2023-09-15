import 'package:flutter/material.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../exceptions/exceptions.dart';

/// Widget, defines rate app list tile, leads to app page on Google Play.
class RateAppTile extends StatelessWidget {
  /// Constructor for [RateAppTile].
  const RateAppTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.star),
        title: Text(context.l10n.rateUsOnGooglePlay),
        trailing: const Icon(Icons.keyboard_arrow_right),
        subtitle: Text(context.l10n.yourFeedbackMotivatesMeToMakeTheAppEvenBetter),
        splashColor: Colors.transparent,
        onTap: () {
          _launchURL(context);
        },
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    const packageName = 'com.oolaa.piececalc';
    const url = 'https://play.google.com/store/apps/details?id=$packageName';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw const CouldNotLaunch();
    }
  }
}
