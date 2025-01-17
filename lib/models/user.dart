class User {
  final String userName, email;

  User({
    required this.userName,
    required this.email,
  });

  factory User.fromJSON(Map<String, dynamic> json) =>
    User(
      userName: json['userName'],
      email: json['email'],
    );

  Map<String, dynamic> toJSON() => {
    'userName': userName,
    'email': email,
  };
}