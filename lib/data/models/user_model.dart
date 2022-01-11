class User {
  final int id;
  final String phoneNumber;
  String name;
  String email;
  String avatar;
  String bio;
  final String dateJoined;

  User({
    required this.id,
    required this.phoneNumber,
    required this.dateJoined,
    this.name = '',
    this.email = '',
    this.avatar = '',
    this.bio = '',
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        phoneNumber = json['phoneNumber'],
        name = json['name'],
        email = json['email'],
        avatar = json['avatar'],
        bio = json['bio'],
        dateJoined = json['dateJoined'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'phoneNumber': phoneNumber,
        'name': name,
        'email': email,
        'avatar': avatar,
        'bio': bio,
        'dateJoined': dateJoined,
      };
}
