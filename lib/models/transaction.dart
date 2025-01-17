class Txn {
  final int? id;
  final double amount;
  final String email, type, category, description, date;

  Txn({
    this.id,
    required this.email,
    required this.type,
    required this.amount,
    required this.category,
    required this.date,
    this.description = 'Not Specified',
  }); 

  factory Txn.fromJSON(Map<String, dynamic> json) =>
    Txn(
      id: json['id'],
      email: json['email'],
      type: json['type'], 
      amount: json['amount'], 
      category: json['category'], 
      date: json['date'],
      description: json['description'],
    );

  Map<String, dynamic> toJSON() => {
    'id': id, 
    'email': email, 
    'type': type, 
    'amount': amount, 
    'category': category, 
    'date': date,
    'description': description,
  };

  
}