import 'package:uuid/uuid.dart';

var uuid = Uuid();

enum ExpenseType { food, travel, leisure, work }

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  ExpenseType category;

  Expense({String? id, required this.title, required this.amount, required this.date, required this.category}) : id = uuid.v4();
}
