class User {
  final String id;
  final String email;
  final String name;
  final String token;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      email: json['email'],
      name: json['name'],
      token: json['token'],
    );
  }
}
