import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../home/home_bloc.dart';
import 'tasks_bloc.dart';
import 'widgets/date_header.dart';
import 'widgets/no_work_has_been_added_widget.dart';
import 'widgets/task_info_list_tile.dart';
import 'widgets/tasks_not_added_yet.dart';

/// A widget that displays all tasks added by the user.
///
/// This page lists out all the tasks the user has
/// saved in the application.
class Tasks extends StatelessWidget {
  /// Creates a [Tasks] widget.
  ///
  /// The [key] parameter is optional and is forwarded to the parent class.
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is WorkDoneLengthEqualsZero) {
          return const NoWorkHasBeenAddedWidget();
        } else {
          return BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              if (state is TasksLoaded) {
                final groupedByDate = state.taskData;
                if (groupedByDate.isEmpty) {
                  return const TasksNotAddedYetWidget();
                }
                return ListView.builder(
                  itemCount: groupedByDate.keys.length,
                  itemBuilder: (context, index) {
                    final date = groupedByDate.keys.elementAt(index);
                    final tasksForThisDate = groupedByDate[date]!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DateHeader(date: date),
                        ...tasksForThisDate.map(
                          (taskInfo) => TaskInfoListTile(
                            taskData: groupedByDate,
                            taskInfo: taskInfo,
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
              if (state is TasksError) {
                Center(child: Text(context.l10n.somethingWentWrong));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }
      },
    );
  }
}
