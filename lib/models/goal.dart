class Goal {
  final int? id;
  final double target_amount;
  final double saved_amount;
  final String title, target_date;

  Goal({
    this.id,

    required this.title,
    required this.target_amount,
    required this.saved_amount,
    required this.target_date,

  });

  factory Goal.fromJSON(Map<String, dynamic> json) =>
      Goal(
        id: json['id'],
        title: json['title'],
        target_amount: json['target_amount'],
        saved_amount: json['saved_amount'],
        target_date: json['target_date'],
      );

  Map<String, dynamic> toJSON() => {
    'id': id,
    'title': title,
    'target_amount': target_amount,
    'saved_amount': saved_amount,
    'target_date': target_date,
  };
}