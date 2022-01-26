import 'package:blitter_flutter_app/data/models.dart';

class BillAttachmentInput {
  final String file;

  const BillAttachmentInput({
    required this.file,
  });

  BillAttachmentInput.fromBillAttachment(BillAttachment attachment)
      : file = attachment.file;
}
