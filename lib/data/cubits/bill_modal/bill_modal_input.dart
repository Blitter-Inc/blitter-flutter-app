import 'package:flutter/material.dart';

import 'package:blitter_flutter_app/data/constants.dart';
import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/data/types.dart';
import './bill_attachment_input.dart';
import './bill_subscriber_input.dart';

class BillModalInput {
  TextEditingController nameController;
  TextEditingController amountController;
  TextEditingController descriptionController;
  String type;
  List<BillSubscriberInput> subscribers;
  List<BillAttachmentInput> attachments;

  BillModalInput({
    required this.nameController,
    required this.amountController,
    required this.descriptionController,
    required this.type,
    required this.subscribers,
    required this.attachments,
  });

  BillModalInput.newBill()
      : nameController = TextEditingController(),
        amountController = TextEditingController(),
        descriptionController = TextEditingController(),
        type = BillType.none,
        subscribers = [],
        attachments = [];

  BillModalInput.fromBill(Bill bill)
      : nameController = TextEditingController(text: bill.name),
        amountController = TextEditingController(text: bill.amount),
        descriptionController = TextEditingController(text: bill.description),
        type = bill.type,
        subscribers = bill.subscribers
            .map((e) => BillSubscriberInput.fromBillSubscriber(e))
            .toList(),
        attachments = bill.attachments
            .map((e) => BillAttachmentInput.fromBillAttachment(e))
            .toList();

  JsonMap toAPIPayload() => {
        'name': nameController.text,
        'amount': amountController.text,
        'description': descriptionController.text,
        'type': type,
        'subscribers': subscribers.map((e) => e.toAPIPayload()).toList(),
        // TODO
        // 'attachments': attachments,
      };

  void dispose() {
    nameController.dispose();
    amountController.dispose();
    descriptionController.dispose();
  }

  bool isValid() {
    final amount = double.tryParse(amountController.text);
    return amount != null &&
        amount > 0 &&
        nameController.text.isNotEmpty &&
        type.isNotEmpty;
  }
}
