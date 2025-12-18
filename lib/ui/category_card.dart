import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';

class CategoryCard extends StatelessWidget {
  final ExpenseType category;
  final double total;

  const CategoryCard({
    super.key,
    required this.category,
    required this.total,
  });

  IconData get icon {
    switch (category) {
      case ExpenseType.food:
        return Icons.fastfood;
      case ExpenseType.travel:
        return Icons.directions_car;
      case ExpenseType.leisure:
        return Icons.movie;
      case ExpenseType.work:
        return Icons.work;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Icon(icon, size: 28),
          const SizedBox(height: 6),
          Text(
            category.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class CategoryCardRow extends StatelessWidget {
  final List<Expense> expenses;

  const CategoryCardRow({super.key, required this.expenses});

  double _calculateTotal(ExpenseType type) {
    double sum = 0;
    for (var expense in expenses) {
      if (expense.category == type) {
        sum += expense.amount;
      }
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,      
        borderRadius: BorderRadius.circular(16), 
      ),
      child: Row(
        children: ExpenseType.values.map((type) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: CategoryCard(
                category: type,
                total: _calculateTotal(type),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}