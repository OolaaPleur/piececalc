import 'dart:math';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/screens/settings/add_work/add_work_helpers.dart';

import '../../../../constants/constants.dart';
import '../../../data/models/work.dart';
import '../../../theme/theme_constants.dart';
import 'cubit/add_work_cubit.dart';
import 'widgets/archived_works_list.dart';
import 'widgets/reorderable_list_of_works.dart';

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
    dialogPickerColor = colorList[random.nextInt(colorList.length)];
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

  // Define your list of colors
  final List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.brown,
  ];

  final random = Random();

  PaymentType workType = PaymentType.piecewisePayment;
  final TextEditingController workNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddWorkCubit, AddWorkState>(
      listener: (context, state) {
        if (state is WorkCanBeDeleted) {
          AddWorkHelpers().showAlertDialog(context, state.workToDelete);
        }
        if (state is WorkSaved && widget.editedObject != null) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: widget.editedObject == null
              ? Text(context.l10n.addNewWork)
              : Text(context.l10n.editWork),
        ),
        body: BlocBuilder<AddWorkCubit, AddWorkState>(
          buildWhen: (previous, current) {
            return current is WorksLoaded;
          },
          builder: (context, state) {
            if (state is WorksLoaded) {
              final active = state.workData.where((work) => work.isArchived == false).toList()
                ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
              return CustomScrollView(
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
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10, top: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary,
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
                                        context
                                            .read<AddWorkCubit>()
                                            .saveData(dataToSave, isEditing: true);
                                      }
                                      workNameController.text = '';
                                      priceController.text = '';
                                      if (widget.editedObject == null) {
                                        setState(() {
                                          dialogPickerColor =
                                              colorList[random.nextInt(colorList.length)];
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    context.l10n.save,
                                    style: TextStyle(
                                      fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                                      color: Theme.of(context).colorScheme.onTertiary,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.editedObject == null)
                    ReorderableListOfWorks(active: active)
                  else
                    const SliverToBoxAdapter(child: SizedBox.shrink()),
                  const SliverToBoxAdapter(
                    child: Divider(),
                  ),
                  if (widget.editedObject == null)
                    ArchivedWorksList(tooltipKey: tooltipKey)
                  else
                    const SliverToBoxAdapter(child: SizedBox.shrink()),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      actionButtons: const ColorPickerActionButtons(
        dialogOkButtonType: ColorPickerActionButtonType.elevated,
        dialogCancelButtonType: ColorPickerActionButtonType.elevated,
        dialogActionIcons: true,
      ),
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
      buttonPadding: const EdgeInsets.all(4),
    );
  }
}
