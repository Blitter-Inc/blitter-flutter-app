import 'package:flutter/material.dart';

import 'package:blitter_flutter_app/config.dart';
import 'package:blitter_flutter_app/data/models.dart';
import './bill_edit_modal.dart';
import './bill_view_modal.dart';

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
  bool _editable = false;

  late AnimationController _modalOpacityController;
  late Animation<double> _modalOpacity;

  Future<void> _toggleEdit() async {
    await _modalOpacityController.reverse();
    setState(() {
      _editable = !_editable;
    });
    _modalOpacityController.forward();
  }

  @override
  void initState() {
    super.initState();
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
            child: !_editable
                ? BillViewModal(
                    bill: widget.bill!,
                    toggleEdit: _toggleEdit,
                  )
                : BillEditModal(
                    bill: widget.bill,
                    toggleEdit: _toggleEdit,
                  ),
          ),
        ),
      ),
    );
  }
}
