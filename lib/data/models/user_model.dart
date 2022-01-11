class User {
  final int id;
  final String phoneNumber;
  final String dateJoined;
  String? name;
  String? email;
  String? avatar;
  String? bio;

  User({
    required this.id,
    required this.phoneNumber,
    required this.dateJoined,
    this.name,
    this.email,
    this.avatar,
    this.bio,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        phoneNumber = json['phoneNumber'],
        dateJoined = json['dateJoined'],
        name = json['name'],
        email = json['email'],
        avatar = json['avatar'],
        bio = json['bio'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'phoneNumber': phoneNumber,
        'dateJoined': dateJoined,
        'name': name,
        'email': email,
        'avatar': avatar,
        'bio': bio,
      };
}
