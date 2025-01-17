class Goal {
  final int? id;
  final double amount;
  final String type, category, description, date;

  Goal({
    this.id,
    required this.type,
    required this.amount,
    required this.category,
    required this.date, 
    this.description = 'Not Specified',
  });

  factory Goal.fromJSON(Map<String, dynamic> json) =>
      Goal(
        id: json['id'],
        type: json['type'],
        amount: json['amount'],
        category: json['category'],
        date: json['date'],
        description: json['description'],
      );

  Map<String, dynamic> toJSON() => {
    'id': id,
    'type': type,
    'amount': amount,
    'category': category,
    'date': date,
    'description': description,
  };
}