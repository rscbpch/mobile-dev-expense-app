import 'package:expense_app/models/expense.dart';
import 'package:expense_app/ui/Expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemove;

  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text('No expenses added yet!'),
      );
    }

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];

        return Dismissible(
          key: ValueKey(expense.id),          
          direction: DismissDirection.endToStart, 
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            onRemove(expense);  
          },
          child: ExpenseItem(expense: expense),
        );
      },
    );
  }
}
