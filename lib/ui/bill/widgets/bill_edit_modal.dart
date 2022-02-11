import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/utils/extensions.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/data/models.dart';
import './amount_input.dart';
import './bottom_modal_button.dart';
import './description_input.dart';
import './bill_action.dart';
import './bill_name_input.dart';
import './bill_type_picker.dart';

class BillEditModal extends StatefulWidget {
  const BillEditModal({
    Key? key,
    required this.bill,
    required this.toggleEdit,
  }) : super(key: key);

  final Bill? bill;
  final AsyncCallback toggleEdit;

  @override
  State<BillEditModal> createState() => _BillEditModalState();
}

class _BillEditModalState extends State<BillEditModal>
    with SingleTickerProviderStateMixin {
  late BillModalInput _input;
  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _initializeModalInput() {
    if (widget.bill != null) {
      _input = BillModalInput.fromBill(widget.bill!);
    } else {
      _input = BillModalInput.newBill();
    }
  }

  void _setBillType(String type) {
    _input.type = type;
  }

  Future<bool> _validate() async => _input.isValid();

  Future<void> _onSubmit(BillModalCubit cubit) async {
    _toggleLoading();
    if (widget.bill != null) {
      await cubit.updateBill(id: widget.bill!.id, input: _input);
      widget.toggleEdit();
    } else {
      await cubit.createBill(input: _input);
      Navigator.of(context).pop();
    }
    _toggleLoading();
  }

  @override
  void initState() {
    super.initState();
    _initializeModalInput();
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return WillPopScope(
      onWillPop: () async {
        if (widget.bill == null) {
          return true;
        } else {
          widget.toggleEdit();
          return false;
        }
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 100),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 40,
                left: 10,
                right: 10,
                bottom: 20,
              ),
              child: Column(
                children: [
                  BillNameInput(
                    controller: _input.nameController,
                    enabled: true,
                  ),
                  const SizedBox(height: 20),
                  AmountInput(
                    controller: _input.amountController,
                    enabled: true,
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  BillTypePicker(
                    initialValue: _input.type,
                    onChanged: _setBillType,
                  ),
                  const SizedBox(height: 20),
                  DescriptionInput(
                    controller: _input.descriptionController,
                    enabled: true,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 100,
              color: colorScheme.modalBackground,
              width: mediaQuery.size.width,
              child: Column(
                children: [
                  const BillAction(),
                  BottomModalButton(
                    label: 'Save',
                    onPressed: () => _onSubmit(context.read<BillModalCubit>()),
                    validate: _validate,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: mediaQuery.size.width,
              color: colorScheme.modalBackground,
              child: Row(
                children: [
                  TextButton(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.arrow_back_ios, size: 12.5),
                          Text('Cancel',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    onPressed: () {
                      if (widget.bill == null) {
                        Navigator.of(context).pop();
                      } else {
                        widget.toggleEdit();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
