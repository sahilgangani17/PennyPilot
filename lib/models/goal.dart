class Goal {
  final int? id;
  final double target_amount;
  final double saved_amount;
  final String title, created_at;

  Goal({
    this.id,
    required this.title,
    required this.target_amount,
    required this.saved_amount,
    required this.created_at,
  });

  factory Goal.fromJSON(Map<String, dynamic> json) =>
      Goal(
        id: json['id'],
        title: json['title'],
        target_amount: json['target_amount'],
        saved_amount: json['saved_amount'],
        created_at: json['created_at'],
      );

  Map<String, dynamic> toJSON() => {
    'id': id,
    'title': title,
    'target_amount': target_amount,
    'saved_amount': saved_amount,
    'created_at': created_at,
  };
}