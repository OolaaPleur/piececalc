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
  @override
  void initState() {
    if (widget.editedObject != null) {
      final edWorkType = widget.editedObject!.paymentType == 'piecewisePayment'
          ? PaymentType.piecewisePayment
          : PaymentType.hourlyPayment;
      workType = widget.editedObject == null ? PaymentType.piecewisePayment : edWorkType;
      workNameController.text = widget.editedObject!.workName;
      priceController.text = widget.editedObject!.price.toString();
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
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
                    Padding(
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
                    Builder(
                      builder: (context) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: saveButtonHorizontalPadding, vertical: saveButtonVerticalPadding),
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
                              );
                              if (widget.editedObject == null) {
                                context.read<AddWorkCubit>().saveData(dataToSave);
                              } else {
                                context.read<AddWorkCubit>().saveData(dataToSave, isEditing: true);
                              }
                              workNameController.text = '';
                              priceController.text = '';
                            }
                          },
                          child: Text(context.l10n.save),
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (widget.editedObject == null)
                BlocBuilder<AddWorkCubit, AddWorkState>(
                  buildWhen: (previous, current) {
                    return current is WorksLoaded;
                  },
                  builder: (context, state) {
                    if (state is WorksLoaded) {
                      return Column(
                        children: List.generate(state.workData.length, (index) {
                          return ListTile(
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
                            key: ValueKey(state.workData[index].id),
                            title: Text(state.workData[index].workName),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('${context.l10n.earned}: ${state.workData[index].price}'),
                                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<AddWorkCubit>()
                                        .checkDeletionPossibility(state.workData[index]);
                                    //
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: deleteIconSize,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
              else
                const SizedBox.shrink(),
            ],
          ),
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
}
