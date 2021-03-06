import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/config.dart';
import 'package:blitter_flutter_app/data/blocs.dart';
import './bill_edit_modal.dart';
import './bill_view_modal.dart';

class BillModal extends StatefulWidget {
  const BillModal({
    Key? key,
    this.billId,
  }) : super(key: key);

  final String? billId;

  @override
  State<BillModal> createState() => _BillModalState();
}

class _BillModalState extends State<BillModal>
    with SingleTickerProviderStateMixin {
  bool _editable = false;
  Widget? subscriberPickerModal;

  late AnimationController _modalOpacityController;
  late Animation<double> _modalOpacity;

  Future<void> _toggleEdit() async {
    await _modalOpacityController.reverse();
    setState(() {
      _editable = !_editable;
    });
    _modalOpacityController.forward();
  }

  bool _hasEditPermission({
    required BuildContext context,
    required int createdBy,
  }) {
    final userId = context.read<AuthBloc>().state.user?.id;
    return createdBy == userId;
  }

  @override
  void initState() {
    super.initState();
    if (widget.billId == null) {
      setState(() {
        _editable = true;
      });
    }
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
    _modalOpacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final billModalCubit = context.read<BillModalCubit>();

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
            child: BlocBuilder<BillBloc, BillState>(
              buildWhen: (previous, current) {
                if (widget.billId == null) {
                  return false;
                }
                return previous.objectMap![widget.billId!]!.lastUpdatedAt !=
                    current.objectMap![widget.billId!]!.lastUpdatedAt;
              },
              builder: (context, state) {
                final bill = widget.billId == null
                    ? null
                    : state.objectMap![widget.billId];
                billModalCubit.bill = bill;
                
                return !_editable
                    ? BillViewModal(
                        bill: bill!,
                        toggleEdit: _toggleEdit,
                        hasEditPermission: _hasEditPermission,
                      )
                    : BillEditModal(
                        bill: bill,
                        toggleEdit: _toggleEdit,
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
