import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:piececalc/constants/constants.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../data/models/composite_task_info.dart';
import '../../../data/models/work.dart';
import '../../../theme/theme_constants.dart';
import '../../../utils/helpers.dart';
import '../../tasks/tasks_bloc.dart';
import 'task_editor_bloc.dart';
import 'text_field_group.dart';
import 'widgets/action_buttons.dart';
import 'widgets/amount_text_field.dart';
import 'widgets/time_picker_widget.dart';
import 'widgets/work_picker.dart';

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
      if (widget.editedObject!.work.paymentType ==
          PaymentType.hourlyPayment.toString().split('.').last) {
        final parts = widget.editedObject!.completedTask.amount.split(':');
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        textFieldGroups.first.time = TimeOfDay(hour: hour, minute: minute);
      }
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
      group.amountFocusNode.dispose();
    }
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TaskEditorBloc, TaskEditorState>(
          listener: (context, state) {
            if (state is TaskSaved || state is TaskDeleted) {
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
              : Text(context.l10n.editTask),
        ),
        body: BlocBuilder<TaskEditorBloc, TaskEditorState>(
          builder: (context, state) {
            if (state is TaskEditorInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TaskEditorError) {
              return Center(
                child: Text(context.l10n.somethingWentWrong),
              );
            }
            if (state is TaskEditorWorksLoaded) {
              final loadedList = state.workData;
              return Form(
                key: _formKey,
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(
                        dateController.text.isNotEmpty
                            ? dateController.text
                            : context.l10n.enterDate,
                      ),
                      subtitle: Text(context.l10n.enterDate),
                      trailing: const Icon(Icons.keyboard_arrow_down),
                      onTap: () async {
                        pickedDate = await showDatePicker(
                          context: context,
                          initialDate: userSelectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
                          userSelectedDate = pickedDate!;
                          setState(() {
                            dateController.text = formattedDate;
                          });
                        }
                      },
                    ),
                    ...textFieldGroups.asMap().entries.map(
                      (entry) {
                        final index = entry.key;
                        final group = entry.value;

                        return Column(
                          children: [
                            WorkPicker(
                              group: group,
                              context: context,
                              state: state,
                              loadedList: loadedList,
                              suggestionPicked: (Work suggestion) {
                                setState(() {
                                  group.typeAheadController.text = suggestion.workName;
                                  group.globalKey.currentState?.validate();
                                  group.amountFocusNode.requestFocus();
                                });
                              },
                            ),
                            Row(
                              children: [
                                if (group.matchedWork?.paymentType ==
                                    PaymentType.hourlyPayment.toString().split('.').last)
                                  Expanded(child: TimePickerWidget(group: group))
                                else
                                  Expanded(
                                    child: AmountTextField(
                                      group: group,
                                      index: index,
                                      textFieldGroups: textFieldGroups,
                                    ),
                                  ),
                                ActionButtons(
                                  editedObject: widget.editedObject,
                                  workData: widget.workData,
                                  onRemove: () {
                                    setState(() {
                                      textFieldGroups.remove(group);
                                    });
                                  },
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        );
                      },
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
                                    final fieldList = <Map<String, dynamic>>[];
                                    for (final textFields in textFieldGroups) {
                                      fieldList.add(
                                        Helpers.convertDataFromTextFieldsIntoMap(
                                          amount: textFields.amountController.text.trim(),
                                          dateCreated: dateController.text.trim(),
                                          workId: textFields.matchedWork!.id,
                                          matchedWork: textFields.matchedWork!,
                                          time: textFields.time,
                                          context: context,
                                          textFieldGroups: textFieldGroups,
                                          editedObject: widget.editedObject,
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
                                child: Text(context.l10n.save),
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
                                      child: Text(context.l10n.addNewField),
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
