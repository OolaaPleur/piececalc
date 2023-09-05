import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:uuid/uuid.dart';

import '../../../../constants/constants.dart';
import '../../../data/models/work.dart';
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
      final edWorkType = widget.editedObject!.paymentType == 'pieceWork'
          ? PaymentType.piecewisePayment
          : PaymentType.hourlyPayment;
      workType = widget.editedObject == null ? PaymentType.piecewisePayment : edWorkType;
      workNameController.text = widget.editedObject!.workName;
      priceController.text = widget.editedObject!.price;
    }
    super.initState();
  }

  PaymentType workType = PaymentType.piecewisePayment;
  final TextEditingController workNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Map<String, dynamic> toMap() {
    if (widget.editedObject != null) {
      final priceWithDot = priceController.text.trim().replaceAll(',', '.');
      final data = <String, dynamic>{
        'id': widget.editedObject!.id,
        'workName': workNameController.text.trim(),
        'workType': workType == PaymentType.piecewisePayment ? 'pieceWork' : 'hourWork',
        'price': priceWithDot,
      };
      return data;
    } else {
      const uuid = Uuid();
      final uniqueKey = uuid.v1();
      final priceWithDot = priceController.text.trim().replaceAll(',', '.');
      final data = <String, dynamic>{
        'id': uniqueKey,
        'workName': workNameController.text.trim(),
        'workType': workType == PaymentType.piecewisePayment ? 'pieceWork' : 'hourWork',
        'price': priceWithDot,
      };
      return data;
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddWorkCubit, AddWorkState>(
      listener: (context, state) {
        if (state is WorkDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('deleted')));
        }
        if (state is WorkCantBeDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('cant delete')));
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
                            return 'Please enter work name';
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
                            return 'Please enter a price';
                          }
                          if (!numericPattern.hasMatch(value)) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();

                            if (_formKey.currentState!.validate()) {
                              // Check if form is valid
                              final dataToSave = toMap();
                              if (widget.editedObject == null) {
                                context.read<AddWorkCubit>().saveData(dataToSave);
                              } else {
                                context.read<AddWorkCubit>().saveData(dataToSave, isEditing: true);
                              }
                            }
                          },
                          child: const Text('Save'),
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (widget.editedObject == null)
                BlocBuilder<AddWorkCubit, AddWorkState>(
                  buildWhen: (previous, current) {
                    return current is! WorkDeleted &&
                        current is! WorkDeleting &&
                        current is! WorksLoading &&
                        current is! WorkSaving &&
                        current is! WorkSaved;
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
                                Text('price: ${state.workData[index].price}'),
                                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                                IconButton(
                                  onPressed: () {
                                    context.read<AddWorkCubit>().deleteWork(state.workData[index]);
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
}
