import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../../data/models/work.dart';
import '../../../../theme/theme_constants.dart';
import '../task_editor_bloc.dart';
import '../text_field_group.dart';

/// Represents a widget that displays a dropdown-like field for users to select a `Work` item.
///
/// The [WorkPicker] utilizes the `TypeAheadFormField` to allow users to search for
/// and select a work item from the provided list of work items.
class WorkPicker extends StatelessWidget {
  /// Creates an instance of the [WorkPicker] widget.
  ///
  /// The [group], [context], [state], [suggestionPicked] and [loadedList] arguments must not be null.
  const WorkPicker({
    required this.group,
    required this.context,
    required this.state,
    required this.loadedList,
    required this.suggestionPicked,
    super.key,
  });

  /// Represents the group of fields related to work input.
  ///
  /// This is used to manage the state and interactions for the `TypeAheadFormField`.
  final TextFieldGroup group;

  /// The build context from which the widget is inserted.
  ///
  /// This is mainly used to fetch localized strings and to read from the BLoC context.
  final BuildContext context;

  /// The state that provides data about the available works.
  ///
  /// This is used to validate the user's input against the available works.
  final TaskEditorWorksLoaded state;

  /// The list of work items available for the user to select from.
  ///
  /// This list is used to generate the suggestions for the `TypeAheadFormField`.
  final List<Work> loadedList;

  /// A callback that is invoked when a suggestion is selected from the dropdown.
  ///
  /// The selected [Work] object is passed as an argument to this callback, allowing
  /// further processing or actions to be performed based on the user's selection.
  final void Function(Work) suggestionPicked;

  @override
  Widget build(BuildContext context) {
    var matches = <Work>[];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: textFieldHorizontalPadding,
        vertical: textFieldVerticalPadding,
      ),
      child: TypeAheadFormField(
        key: group.globalKey,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return context.l10n.pleaseEnterWorkName;
          }
          // Find the work that matches the text value of _typeAheadController
          for (final work in state.workData) {
            if (work.workName == group.typeAheadController.text) {
              group.matchedWork = work;
              return null;
            }
          }
          if (group.matchedWork == null) {
            return context.l10n.pleaseEnterValidWorkName;
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
                (s) => s.workName.toLowerCase().startsWith(pattern.toLowerCase()),
              )
              .toList();

          final containsMatches = matches
              .where(
                (s) => s.workName.toLowerCase().contains(pattern.toLowerCase()),
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
        onSuggestionSelected: suggestionPicked,
      ),
    );
  }
}
