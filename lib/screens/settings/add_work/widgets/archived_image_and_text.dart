import 'package:flutter/material.dart';
import 'package:piececalc/l10n/l10n.dart';

/// Widget, defines archive image and text, when there is no work.
class ArchiveImageAndText extends StatelessWidget {
  /// Constructor for [ArchiveImageAndText].
  const ArchiveImageAndText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: CircleAvatar(
            radius: 100,
            child: ClipOval(child: Image.asset('assets/empty_archive.png')),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          child: Text(
            context.l10n.worksHasntBeenArchivedYetToArchiveWorkTapThreedot,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
            ),
          ),
        ),
      ],
    );
  }
}
