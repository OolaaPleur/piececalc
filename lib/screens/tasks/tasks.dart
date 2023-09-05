import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/add_done_work/task_editor.dart';
import '../home/add_done_work/task_editor_bloc.dart';
import '../home/home_bloc.dart';
import '../settings/add_work/add_work_cubit.dart';
import '../settings/add_work/add_work_page.dart';
import '../settings/currency_picker/currency_picker_cubit.dart';
import 'tasks_bloc.dart';

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
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No work has been added. To add new work \n1) Go to Settings \n2) Click "Add new Work" tile',
                  ),
                  TextButton(
                    onPressed: () {
                      final cubit = context.read<AddWorkCubit>();
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => BlocProvider.value(
                            value: cubit,
                            child: const AddWorkPage(),
                          ),
                        ),
                      );
                    },
                    child: const Text('Or press this button'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              if (state is TasksLoaded) {
                final groupedByDate = state.taskData;
                if (groupedByDate.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Text('Tasks not added yet, press plus button at the bottom right'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) {
                                  context.read<TaskEditorBloc>().add(LoadWorkEvent());
                                  return const TaskEditor();
                                },
                              ),
                            );
                          },
                          child: const Text('Or press this button'),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: groupedByDate.keys.length,
                  itemBuilder: (context, index) {
                    final date = groupedByDate.keys.elementAt(index);
                    final tasksForThisDate = groupedByDate[date]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            date,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ...tasksForThisDate.map(
                          (taskInfo) => ListTile(
                            onTap: () {
                              context.read<TaskEditorBloc>().add(LoadWorkEvent());
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (context) => TaskEditor(
                                    editedObject: taskInfo,
                                    workData: state.taskData,
                                  ),
                                ),
                              );
                            },
                            key: ValueKey(taskInfo.completedTask.id),
                            title: Text(taskInfo.work.workName),
                            subtitle: BlocBuilder<CurrencyPickerCubit, CurrencyPickerState>(
                              builder: (context, currencyPickerState) {
                                if (currencyPickerState is CurrencyLoaded) {
                                  return Text(
                                    'price: ${taskInfo.work.price}${currencyPickerState.currencyName['symbol']}',
                                  );
                                } else {
                                  return Text('price: ${taskInfo.work.price}');
                                }
                              },
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('amount: ${taskInfo.completedTask.amount}'),
                                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                                IconButton(
                                  onPressed: () {
                                    context.read<TasksCubit>().deleteTask(state.taskData, taskInfo);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 30,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
              if (state is TasksError) {
                return const Center(child: Text('Tasks not added yet'));
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
