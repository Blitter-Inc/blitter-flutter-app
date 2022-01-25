import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/utils/extensions.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/data/models.dart';
import './amount_input.dart';
import './description_input.dart';
import './bottom_modal_submit_button.dart';
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

  void _initializeModalInput() {
    if (widget.bill != null) {
      _input = BillModalInput.fromBill(widget.bill!);
    } else {
      _input = BillModalInput.newBill();
    }
  }

  void _setBillType(String type) {
    print('SET BILLL TYPE TRIGGERED with value: $type');
    _input.type = type;
  }

  Future<void> _onSubmit(BillModalCubit cubit) async {
    print(_input.toAPIPayload());
    widget.toggleEdit();
    // if (widget.bill != null) {
    //   cubit.updateBill(id: widget.bill!.id, input: _input);
    // } else {
    //   cubit.createBill(input: _input);
    // }
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

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 100),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
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
            color: Theme.of(context).colorScheme.bottomSheetModalBackground,
            width: mediaQuery.size.width,
            child: Column(
              children: [
                const BillAction(),
                BottomModalSubmitButton(
                    onSubmit: () => _onSubmit(context.read<BillModalCubit>())),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
