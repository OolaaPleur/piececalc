import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../add_work_page.dart';
import '../cubit/add_work_cubit.dart';
import 'archived_header.dart';
import 'archived_image_and_text.dart';
import 'three_dot_menu.dart';

/// Widget, defines Archived works list.
class ArchivedWorksList extends StatefulWidget {
  /// Constructor for [ArchivedWorksList].
  const ArchivedWorksList({
    required this.tooltipKey,
    super.key,
  });

  /// Global key for tooltip.
  final GlobalKey<TooltipState> tooltipKey;

  @override
  State<ArchivedWorksList> createState() => _ArchivedWorksListState();
}

class _ArchivedWorksListState extends State<ArchivedWorksList> {
  final archivedEmptyNotifier =
      ValueNotifier<bool>(true); // Initialized with true assuming initially it's empty.

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddWorkCubit, AddWorkState>(
      buildWhen: (previous, current) {
        return current is WorksLoaded;
      },
      builder: (context, state) {
        final archived = state.workData.where((work) => work.isArchived == true).toList();
        archivedEmptyNotifier.value = archived.isEmpty;

        if (state is WorksLoaded) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Place AnimatedOpacity at index 0
                if (index == 0) {
                  return HeaderAndTooltip(
                    tooltipKey: widget.tooltipKey,
                    tooltipText: context.l10n.archivedWorksArentShowingInAddTaskWorkSuggestions,
                    title: context.l10n.archiveHeader,
                    isChart: false,
                  );
                }

                if (index == 1) {
                  return AnimatedCrossFade(
                    duration: const Duration(milliseconds: 700),
                    crossFadeState:
                        archived.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    firstChild: const ArchiveImageAndText(),
                    secondChild: const SizedBox(), // This represents the "disappeared" state.
                  );
                }

                return Card(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: archived[index - 2].workColor,
                          width: 16,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Text(archived[index - 2].workName),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ThreeDotMenu(
                            workToMakeAnAction: archived[index - 2],
                            isArchiving: false,
                          ),
                        ],
                      ),
                      onTap: () {
                        final cubit = context.read<AddWorkCubit>();
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => BlocProvider.value(
                              value: cubit,
                              child: AddWorkPage(editedObject: archived[index - 2]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              childCount: archived.length + 2, // +2 to account for AnimatedOpacity and the header
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
