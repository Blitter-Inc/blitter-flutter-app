import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/config.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/data/models.dart';
import './amount_input.dart';
import './description_input.dart';
import './bottom_modal_submit_button.dart';
import './bill_action.dart';
import './bill_edit_toggle.dart';
import './bill_name_input.dart';
import './bill_type_badge.dart';
import './bill_type_picker.dart';

class BillModal extends StatefulWidget {
  const BillModal({
    Key? key,
    required this.bill,
  }) : super(key: key);

  final Bill? bill;

  @override
  State<BillModal> createState() => _BillModalState();
}

class _BillModalState extends State<BillModal>
    with SingleTickerProviderStateMixin {
  late BillModalInput _input;
  bool _editable = false;

  late AnimationController _modalOpacityController;
  late Animation<double> _modalOpacity;

  Future<void> _toggleEditMode() async {
    await _modalOpacityController.reverse();
    setState(() {
      _editable = !_editable;
    });
    _modalOpacityController.forward();
  }

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
    _toggleEditMode();
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
    _modalOpacityController = AnimationController(
      vsync: this,
      duration: defaultTransitionDuration,
    );
    _modalOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _modalOpacityController,
        curve: Curves.easeInOutQuint,
      ),
    );
    _modalOpacityController.forward();
  }

  @override
  void dispose() {
    _input.dispose();
    _modalOpacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      child: FadeTransition(
        opacity: _modalOpacity,
        child: Container(
          padding: EdgeInsets.only(
            bottom: mediaQuery.viewInsets.bottom,
          ),
          constraints: BoxConstraints(
            maxHeight: mediaQuery.size.height - 125,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: _editable ? 100 : 50),
                  padding: EdgeInsets.only(top: _editable ? 0 : 7),
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
                          enabled: _editable,
                        ),
                        const SizedBox(height: 20),
                        AmountInput(
                          controller: _input.amountController,
                          enabled: _editable,
                        ),
                        const SizedBox(height: 10),
                        if (_editable) ...[
                          const Divider(),
                          BillTypePicker(
                            initialValue: _input.type,
                            onChanged: _setBillType,
                          ),
                        ],
                        if (_editable ||
                            (!_editable &&
                                _input.descriptionController.text
                                    .isNotEmpty)) ...[
                          const SizedBox(height: 20),
                          DescriptionInput(
                            controller: _input.descriptionController,
                            enabled: _editable,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                if (!_editable) ...[
                  BillTypeBadge(type: _input.type),
                  BillEditToggle(onTap: _toggleEditMode),
                ] else
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 100,
                      color: Theme.of(context)
                          .colorScheme
                          .bottomSheetModalBackground,
                      width: mediaQuery.size.width,
                      child: Column(
                        children: [
                          const BillAction(),
                          BottomModalSubmitButton(
                              onSubmit: () =>
                                  _onSubmit(context.read<BillModalCubit>())),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
