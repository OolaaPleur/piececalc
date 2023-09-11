import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../constants/constants.dart';
import '../../../data/models/composite_task_info.dart';
import '../../../theme/theme_constants.dart';
import '../../../utils/helpers.dart';
import '../../home/task_editor/task_editor.dart';
import '../../home/task_editor/task_editor_bloc.dart';
import '../tasks_bloc.dart';
import 'price_text_widget.dart';

/// Widget that defines how task info list tile looks like.
class TaskInfoListTile extends StatelessWidget {

  /// Constructor for [TaskInfoListTile].
  const TaskInfoListTile({required this.taskInfo, required this.taskData, super.key});
  /// Work info and Task info combined.
  final CompositeTaskInfo taskInfo;
  /// Data about all composite task info objects with date as key.
  final Map<String, List<CompositeTaskInfo>> taskData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<TaskEditorBloc>().add(LoadWorkEvent());
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => TaskEditor(
              editedObject: taskInfo,
              workData: taskData,
            ),
          ),
        );
      },
      key: ValueKey(taskInfo.completedTask.id),
      title: Text(taskInfo.work.workName),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: listTilePadding),
        child: _buildSubtitleText(taskInfo, context),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PriceTextWidget(taskInfo: taskInfo),
          if (kDebugMode) IconButton(
            onPressed: () {
              context.read<TasksCubit>().deleteTask(taskData, taskInfo);
            },
            icon: Icon(
              Icons.delete,
              size: 30,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitleText(CompositeTaskInfo taskInfo, BuildContext context) {
    if (taskInfo.work.paymentType == PaymentType.piecewisePayment.toString().split('.').last) {
      return Text(
        '${context.l10n.amount}: ${Helpers.formatNumber(double.parse(taskInfo.completedTask.amount))}',
        style: TextStyle(fontSize: Theme.of(context).textTheme.labelLarge!.fontSize),
      );
    } else {
      return Text(
        '${context.l10n.timeSpent}: ${Helpers.formatDuration(taskInfo.completedTask.amount, context)}',
        style: TextStyle(fontSize: Theme.of(context).textTheme.labelLarge!.fontSize),
      );
    }
  }
}
