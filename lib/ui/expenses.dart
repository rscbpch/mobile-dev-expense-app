import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/ui/expense_list.dart';
import 'package:expense_app/ui/expense_form.dart';
import 'package:expense_app/ui/category_card.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenses = [
    Expense(
      title: 'Lunch',
      amount: 15.50,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: ExpenseType.food,
    ),
    Expense(
      title: 'Taxi Ride',
      amount: 25.00,
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: ExpenseType.travel,
    ),
    Expense(
      title: 'Movie Ticket',
      amount: 12.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
      category: ExpenseType.leisure,
    ),
    Expense(
      title: 'Office Supplies',
      amount: 45.75,
      date: DateTime.now().subtract(const Duration(days: 4)),
      category: ExpenseType.work,
    ),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final index = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
    });

    // Show SnackBar with undo
    ScaffoldMessenger.of(context).clearSnackBars(); // remove previous snackbars
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${expense.title} removed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _expenses.insert(index, expense);
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _openAddExpenseModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ExpenseForm(onAdd: _addExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openAddExpenseModal(context),
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CategoryCardRow(expenses: _expenses),
            const SizedBox(height: 16),
            Expanded(
              child: ExpenseList(
                expenses: _expenses,
                onRemove: _removeExpense, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}