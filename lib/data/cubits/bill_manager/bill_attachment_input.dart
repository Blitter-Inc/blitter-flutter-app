import 'package:blitter_flutter_app/data/models.dart';

class BillAttachmentInput {
  final String file;
  final int? id;
  final String? name;
  final String? createdAt;
  final String? lastUpdatedAt;

  const BillAttachmentInput({
    required this.file,
    this.id,
    this.name,
    this.createdAt,
    this.lastUpdatedAt,
  });

  BillAttachmentInput.fromBillAttachment(BillAttachment attachment)
      : file = attachment.file,
        id = attachment.id,
        name = attachment.name,
        createdAt = attachment.createdAt,
        lastUpdatedAt = attachment.lastUpdatedAt;
}
