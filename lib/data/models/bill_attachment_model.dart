class BillAttachment {
  final int id;
  final String name;
  final String file;
  final String createdAt;
  final String lastUpdatedAt;

  const BillAttachment({
    required this.id,
    required this.name,
    required this.file,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  BillAttachment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        file = json['file'],
        createdAt = json['createdAt'],
        lastUpdatedAt = json['lastUpdatedAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'file': file,
        'createdAt': createdAt,
        'lastUpdatedAt': lastUpdatedAt,
      };
}
