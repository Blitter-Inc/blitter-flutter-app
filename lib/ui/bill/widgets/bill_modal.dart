import 'package:flutter/material.dart';

import 'package:blitter_flutter_app/config.dart';
import './amount_input.dart';
import './description_input.dart';
import './bottom_modal_submit_button.dart';
import './bill_action.dart';
import './bill_name_input.dart';
import './bill_type_picker.dart';

class BillModal extends StatelessWidget {
  const BillModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
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
              margin: const EdgeInsets.only(bottom: 100),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 20,
                ),
                child: Column(
                  children: const [
                    BillNameInput(),
                    SizedBox(height: 20),
                    AmountInput(),
                    SizedBox(height: 10),
                    Divider(),
                    BillTypePicker(),
                    SizedBox(height: 20),
                    DescriptionInput(),
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
                  children: const [
                    BillAction(),
                    BottomModalSubmitButton(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
