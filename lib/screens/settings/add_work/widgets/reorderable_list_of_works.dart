import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../../data/models/work.dart';
import '../../../../theme/theme_constants.dart';
import '../../../../utils/helpers.dart';
import '../add_work_page.dart';
import '../cubit/add_work_cubit.dart';
import 'three_dot_menu.dart';

/// List of reorderable, not archived, works.
class ReorderableListOfWorks extends StatelessWidget {
  /// Constructor for [ReorderableListOfWorks].
  const ReorderableListOfWorks({
    required this.active, super.key,
  });

  /// List of active (not archived) works.
  final List<Work> active;

  @override
  Widget build(BuildContext context) {
    return SliverReorderableList(
      itemCount: active.length,
      itemBuilder: (context, index) {
        return Material(
          key: ValueKey(active[index].id),
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: active[index].workColor,
                    width: 16,
                  ),
                ),
              ),
              child: ListTile(
                onTap: () {
                  final cubit = context.read<AddWorkCubit>();
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) =>
                          BlocProvider.value(
                            value: cubit,
                            child: AddWorkPage(editedObject: active[index]),
                          ),
                    ),
                  );
                },
                leading: ReorderableDragStartListener(
                  index: index,
                  child: const IconButton(
                    icon: Icon(Icons.drag_handle),
                    onPressed: null,
                    iconSize: 32,
                  ),
                ),
                title: Text(active[index].workName),
                subtitle: Text(
                  '${context.l10n.earned}: ${Helpers.formatNumber(
                      active[index].price,)}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                    if (kDebugMode)
                      IconButton(
                        onPressed: () {
                          context
                              .read<AddWorkCubit>()
                              .checkDeletionPossibility(active[index]);
                        },
                        icon: Icon(
                          Icons.delete,
                          size: deleteIconSize,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .error,
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    ThreeDotMenu(
                      workToMakeAnAction: active[index],
                      isArchiving: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final item = active.removeAt(oldIndex);
        active.insert(newIndex, item);

        // Create a new list with updated orderIndex for each item
        final updatedWorkData = <Work>[];
        for (var i = 0; i < active.length; i++) {
          updatedWorkData.add(active[i].copyWith(orderIndex: i));
        }
        // Save the new order to the database
        context.read<AddWorkCubit>().saveOrder(updatedWorkData);
      },
    );
  }
}
