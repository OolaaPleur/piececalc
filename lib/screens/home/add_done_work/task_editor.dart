import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:piececalc/constants/constants.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/composite_task_info.dart';
import '../../../data/models/work.dart';
import '../../tasks/tasks_bloc.dart';
import 'task_editor_bloc.dart';
import 'text_field_group.dart';

/// A StatefulWidget that provides functionality to add new tasks or edit
/// previously added tasks.
///
/// The page allows users to create a new task or modify the details
/// of an existing task based on the provided [editedObject].
///
/// If [editedObject] is provided, the page will pre-fill the details
/// and allow the user to update them. If [editedObject] is null,
/// the page will provide an interface to create a new task.
///
/// The [workData] is used as argument for deleting function.
class TaskEditor extends StatefulWidget {
  /// Constructs an instance of [TaskEditor].
  ///
  /// [editedObject] (optional) is the task information that needs to
  /// be edited. If not provided, the widget will be in the 'add' mode.
  ///
  /// [workData] (optional) is a collection of existing tasks, mainly
  /// used as a reference or for deletion functionality.
  const TaskEditor({
    super.key,
    this.editedObject,
    this.workData,
  });

  /// Represents a task that the user wishes to edit.
  /// If null, it indicates the widget is in 'add' mode.
  final CompositeTaskInfo? editedObject;

  /// A collection of existing tasks. Primarily used for reference
  /// or deletion operations.
  final Map<String, List<CompositeTaskInfo>>? workData;

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  final _formKey = GlobalKey<FormState>();
  List<TextFieldGroup> textFieldGroups = [];
  final dateController =
      TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  DateTime? pickedDate = DateTime.now();
  late DateTime userSelectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.editedObject == null) {
      textFieldGroups.add(TextFieldGroup());
      userSelectedDate = DateTime.now();
    } else {
      final dateCreated = DateTime.parse(widget.editedObject!.completedTask.dateCreated);
      textFieldGroups.add(TextFieldGroup());
      userSelectedDate = dateCreated;
      dateController.text = dateCreated.toIso8601String().split('T').first;
      textFieldGroups.first.matchedWork = widget.editedObject!.work;
      textFieldGroups.first.amountController.text = widget.editedObject!.completedTask.amount;
      textFieldGroups.first.typeAheadController.text = widget.editedObject!.work.workName;
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (final group in textFieldGroups) {
      group.amountController.dispose();
      group.typeAheadController.dispose();
      group.typeAheadFocusNode.dispose();
    }
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var matches = <Work>[];

    bool checkIfThereIsEmptyPickedWork() {
      var oneOfTaskHasEmptyPickedWork = false;
      for (final textFields in textFieldGroups) {
        if (textFields.matchedWork == null) {
          return oneOfTaskHasEmptyPickedWork = true;
        }
      }
      return oneOfTaskHasEmptyPickedWork;
    }

    Map<String, dynamic> toMap({
      required String amount,
      required String dateCreated,
      required String workId,
    }) {
      if (widget.editedObject != null) {
        final amountWithDot = amount.replaceAll(',', '.');
        final data = <String, dynamic>{
          'id': widget.editedObject!.completedTask.id,
          'workId': workId,
          'amount': amountWithDot,
          'dateCreated': dateCreated,
        };
        return data;
      } else {
        const uuid = Uuid();
        final uniqueKey = uuid.v1();
        final amountWithDot = amount.replaceAll(',', '.');
        if (!checkIfThereIsEmptyPickedWork()) {
          final data = <String, dynamic>{
            'id': uniqueKey,
            'workId': workId,
            'amount': amountWithDot,
            'dateCreated': dateCreated,
          };
          return data;
        }
      }
      return {};
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<TaskEditorBloc, TaskEditorState>(
          listener: (context, state) {
            if (state is TaskSaved) {
              context.read<TasksCubit>().loadData();
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<TasksCubit, TasksState>(
          listener: (context, state) {
            if (state is TaskDeleted) {
              context.read<TasksCubit>().loadData();
              Navigator.pop(context);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: widget.editedObject == null
              ? Text(context.l10n.addDoneWork)
              : const Text('Edit task'),
        ),
        body: BlocBuilder<TaskEditorBloc, TaskEditorState>(
          builder: (context, state) {
            if (state is TaskEditorInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WorksLoadedRefactorNextTime) {
              final loadedList = state.workData;
              return Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: textFieldHorizontalPadding,
                        vertical: textFieldVerticalPadding,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter date';
                          }
                          return null;
                        },
                        controller: dateController,
                        //editing controller of this TextField
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: 'Enter Date', //label text of field
                        ),
                        readOnly: true,
                        // when true user cannot edit text
                        onTap: () async {
                          pickedDate = await showDatePicker(
                            context: context,
                            initialDate: userSelectedDate,
                            //get today's date
                            firstDate: DateTime(2000),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            log(
                              pickedDate.toString(),
                            ); //get the picked date in the format => 2022-07-04 00:00:00.000
                            final formattedDate = DateFormat('yyyy-MM-dd').format(
                              pickedDate!,
                            ); // format date in required form here we use yyyy-MM-dd that means time is removed
                            //You can format date as per your need
                            userSelectedDate = pickedDate!;
                            setState(() {
                              dateController.text =
                                  formattedDate; //set formatted date to TextField value.
                            });
                          } else {
                            log('Date is not selected');
                          }
                        },
                      ),
                    ),
            ...textFieldGroups.asMap().entries.map(
                      (entry) {
                        final index = entry.key;
                        final group = entry.value;
                        return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: textFieldHorizontalPadding,
                              vertical: textFieldVerticalPadding,
                            ),
                            child: TypeAheadFormField(
                              key: group.uniqueKey,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter work name';
                                }
                                // Find the work that matches the text value of _typeAheadController
                                for (final work in state.workData) {
                                  if (work.workName == group.typeAheadController.text) {
                                    group.matchedWork = work;
                                    return null;
                                  }
                                }
                                if (group.matchedWork == null) {
                                  return 'Please enter valid work name';
                                }
                                return null;
                              },
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(labelText: context.l10n.workName),
                                onTapOutside: (event) {
                                  group.typeAheadFocusNode.unfocus();
                                },
                                focusNode: group.typeAheadFocusNode,
                                controller: group.typeAheadController,
                              ),
                              suggestionsCallback: (pattern) async {
                                context.read<TaskEditorBloc>().add(LoadWorkEvent());
                                matches = <Work>[...loadedList];

                                final startsWithMatches = matches
                                    .where(
                                      (s) => s.workName
                                          .toLowerCase()
                                          .startsWith(pattern.toLowerCase()),
                                    )
                                    .toList();

                                final containsMatches = matches
                                    .where(
                                      (s) =>
                                          s.workName.toLowerCase().contains(pattern.toLowerCase()),
                                    )
                                    .toList();

                                startsWithMatches.addAll(containsMatches);
                                return startsWithMatches.toSet().toList();
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  leading: const Icon(Icons.warehouse),
                                  title: Text(suggestion.workName),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                group.typeAheadController.text = suggestion.workName;
                                group.amountFocusNode.requestFocus();
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: textFieldHorizontalPadding,
                                    vertical: textFieldVerticalPadding,
                                  ),
                                  child: TextFormField(
                                    focusNode: group.amountFocusNode,
                                    keyboardType: TextInputType.number,
                                    controller: group.amountController,
                                    decoration: InputDecoration(labelText: context.l10n.workAmount),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an amount';
                                      }
                                      if (!numericPattern.hasMatch(value)) {
                                        return 'Please enter a valid number';
                                      }
                                      return null;
                                    },
                                    onFieldSubmitted: (_) {
                                      if (index < textFieldGroups.length - 1) {
                                        group.amountFocusNode.unfocus();
                                        FocusScope.of(context).requestFocus(textFieldGroups[index + 1].typeAheadFocusNode);
                                      } else {
                                        group.amountFocusNode.unfocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                              if (widget.editedObject != null)
                                Builder(
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: textFieldHorizontalPadding,
                                        vertical: textFieldVerticalPadding,
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            final cti = widget.editedObject!;
                                            context
                                                .read<TasksCubit>()
                                                .deleteTask(widget.workData!, cti);
                                            //Navigator.pop(context);
                                          });
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    );
                                  },
                                )
                              else
                                Builder(
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: textFieldHorizontalPadding,
                                        vertical: textFieldVerticalPadding,
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            textFieldGroups.remove(group);
                                            //Navigator.pop(context);
                                          });
                                        },
                                        child: const Text('Remove field'),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                          const Divider(),
                        ],
                      );},
                    ),
                    Builder(
                      builder: (context) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: textFieldHorizontalPadding,
                                vertical: textFieldVerticalPadding,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Check if form is valid
                                    //final dataToSave = toMap();
                                    final fieldList = <Map<String, dynamic>>[];
                                    for (final textFields in textFieldGroups) {
                                      fieldList.add(
                                        toMap(
                                          amount: textFields.amountController.text.trim(),
                                          dateCreated: dateController.text.trim(),
                                          workId: textFields.matchedWork!.id,
                                        ),
                                      );
                                    }

                                    if (widget.editedObject == null) {
                                      context
                                          .read<TaskEditorBloc>()
                                          .add(SaveTaskEvent(fieldList, isEditing: false));
                                    } else {
                                      context
                                          .read<TaskEditorBloc>()
                                          .add(SaveTaskEvent(fieldList, isEditing: true));
                                    }
                                  }
                                },
                                child: const Text('Save'),
                              ),
                            ),
                            if (widget.editedObject == null)
                              Builder(
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: textFieldHorizontalPadding,
                                      vertical: textFieldVerticalPadding,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          textFieldGroups.add(TextFieldGroup());
                                        });
                                      },
                                      child: const Text('Add new field'),
                                    ),
                                  );
                                },
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
