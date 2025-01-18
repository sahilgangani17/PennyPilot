class User {
  final int? id;
  final String  email;
  
  const User({
    this.id,
    required this.email,
  });

  factory User.fromJSON(Map<String, dynamic> json) =>
    User(
      id: json['id'],
      email: json['email'],
    );

  Map<String, dynamic> toJSON() => {
    'id': id,
    'email': email,
  };
}