import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/screens/settings/add_work/helpers.dart';
import 'package:piececalc/widgets/snackbar.dart';

import '../../../../constants/constants.dart';
import '../../../data/models/work.dart';
import '../../../theme/theme_constants.dart';
import 'add_work_cubit.dart';

/// Page, where city could be selected by user.
class AddWorkPage extends StatefulWidget {
  /// Constructor for [AddWorkPage].
  const AddWorkPage({super.key, this.editedObject});

  /// If editedObject is passed, it means its editing mode
  /// of already existing task, if not - its creating
  /// new one.
  final Work? editedObject;

  @override
  State<AddWorkPage> createState() => _AddWorkPageState();
}

class _AddWorkPageState extends State<AddWorkPage> {
  late Color dialogPickerColor; // Color for picker in dialog using onChanged

  @override
  void initState() {
    dialogPickerColor = Colors.blue;
    if (widget.editedObject != null) {
      final edWorkType = widget.editedObject!.paymentType == 'piecewisePayment'
          ? PaymentType.piecewisePayment
          : PaymentType.hourlyPayment;
      workType = widget.editedObject == null ? PaymentType.piecewisePayment : edWorkType;
      workNameController.text = widget.editedObject!.workName;
      priceController.text = widget.editedObject!.price.toString();
      dialogPickerColor = widget.editedObject!.workColor;
    }
    super.initState();
  }

  PaymentType workType = PaymentType.piecewisePayment;
  final TextEditingController workNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddWorkCubit, AddWorkState>(
      listener: (context, state) {
        if (state is WorkDeleted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AppSnackBar(context, message: context.l10n.workDeleted).showSnackBar());
        }
        if (state is WorkCantBeDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            AppSnackBar(context, message: context.l10n.workIsAlreadyUsedInTaskCantDelete)
                .showSnackBar(),
          );
        }
        if (state is WorkCanBeDeleted) {
          showAlertDialog(context, state.workToDelete);
        }
        if (state is WorkSaved && widget.editedObject != null) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.addNewWork)),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: textFieldHorizontalPadding,
                        vertical: textFieldVerticalPadding,
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: workNameController,
                        decoration: InputDecoration(labelText: context.l10n.workName),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.pleaseEnterWorkName;
                          }
                          return null;
                        },
                      ),
                    ),
                    Column(
                      children: [
                        RadioListTile(
                          title: Text(context.l10n.pieceWork),
                          value: PaymentType.piecewisePayment,
                          groupValue: workType,
                          onChanged: (value) {
                            setState(() {
                              workType = value!;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(context.l10n.hourWork),
                          value: PaymentType.hourlyPayment,
                          groupValue: workType,
                          onChanged: (value) {
                            setState(() {
                              workType = value!;
                            });
                          },
                        ),
                      ],
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
                              keyboardType: TextInputType.number,
                              controller: priceController,
                              decoration: InputDecoration(
                                labelText: workType == PaymentType.piecewisePayment
                                    ? context.l10n.priceForOnePiece
                                    : context.l10n.priceForOneHour,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context.l10n.pleaseEnterAPrice;
                                }
                                if (!numericPattern.hasMatch(value)) {
                                  return context.l10n.pleaseEnterAValidNumber;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: textFieldHorizontalPadding,
                            top: textFieldVerticalPadding,
                            bottom: textFieldVerticalPadding,
                          ),
                          child: ColorIndicator(
                            width: 44,
                            height: 44,
                            borderRadius: 100,
                            color: dialogPickerColor,
                            onSelectFocus: false,
                            onSelect: () async {
                              // Store current color before we open the dialog.
                              final colorBeforeDialog = dialogPickerColor;
                              // Wait for the picker to close, if dialog was dismissed,
                              // then restore the color we had before it was opened.
                              if (!(await colorPickerDialog())) {
                                setState(() {
                                  dialogPickerColor = colorBeforeDialog;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Builder(
                      builder: (context) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: saveButtonHorizontalPadding,
                              vertical: saveButtonVerticalPadding,
                            ),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();

                            if (_formKey.currentState!.validate()) {
                              // Check if form is valid
                              final dataToSave = AddWorkHelpers.convertTextFieldsDataToWork(
                                editedObject: widget.editedObject,
                                workName: workNameController.text.trim(),
                                workType: workType,
                                priceController: priceController,
                                workColor: dialogPickerColor,
                              );
                              if (widget.editedObject == null) {
                                context.read<AddWorkCubit>().saveData(dataToSave);
                              } else {
                                context.read<AddWorkCubit>().saveData(dataToSave, isEditing: true);
                              }
                              workNameController.text = '';
                              priceController.text = '';
                              setState(() {
                                dialogPickerColor = Colors.blue;
                              });
                            }
                          },
                          child: Text(context.l10n.save),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (widget.editedObject == null)
              BlocBuilder<AddWorkCubit, AddWorkState>(
                buildWhen: (previous, current) {
                  return current is WorksLoaded;
                },
                builder: (context, state) {
                  if (state is WorksLoaded) {
                    return SliverReorderableList(
                      itemCount: state.workData.length,
                      itemBuilder: (context, index) {
                        return Material(
                          key: ValueKey(state.workData[index].id),
                          child: ListTile(
                            onTap: () {
                              final cubit = context.read<AddWorkCubit>();
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (context) => BlocProvider.value(
                                    value: cubit,
                                    child: AddWorkPage(editedObject: state.workData[index]),
                                  ),
                                ),
                              );
                            },
                            leading: ReorderableDragStartListener(
                              index: index,
                              child: const Icon(Icons.drag_handle),
                            ),
                            title: Text(state.workData[index].workName),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('${context.l10n.earned}: ${state.workData[index].price}'),
                                ColorIndicator(
                                  width: 30,
                                  height: 30,
                                  borderRadius: 100,
                                  color: state.workData[index].workColor,
                                  onSelectFocus: false,
                                ),
                                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<AddWorkCubit>()
                                        .checkDeletionPossibility(state.workData[index]);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: deleteIconSize,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      onReorder: (oldIndex, newIndex) {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final item = state.workData.removeAt(oldIndex);
                        state.workData.insert(newIndex, item);

                        // Create a new list with updated orderIndex for each item
                        final updatedWorkData = <Work>[];
                        for (var i = 0; i < state.workData.length; i++) {
                          updatedWorkData.add(state.workData[i].copyWith(orderIndex: i));
                        }
                        // Save the new order to the database
                        context.read<AddWorkCubit>().saveOrder(updatedWorkData);
                      },
                    );
                  }
                  // Consider returning a different Sliver widget for other states
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              )
            else
              const SliverToBoxAdapter(child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context, Work work) {
    // set up the buttons
    final Widget cancelButton = TextButton(
      child: Text(context.l10n.yes),
      onPressed: () {
        context.read<AddWorkCubit>().deleteWork(work);
        Navigator.pop(context);
      },
    );
    final Widget continueButton = TextButton(
      child: Text(context.l10n.no),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    final alert = AlertDialog(
      title: Text(context.l10n.workDeletion),
      content: Text(context.l10n.wouldYouLikeToDeleteThisWork),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChanged: (Color color) => setState(() => dialogPickerColor = color),
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        context.l10n.selectColor,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subheading: Text(
        context.l10n.selectColorShade,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      wheelSubheading: Text(
        context.l10n.selectedColorAndItsShades,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      showMaterialName: true,
      showColorName: true,
      //showColorCode: true,
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
      colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
    ).showPickerDialog(
      context,
      actionsPadding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    );
  }
}
