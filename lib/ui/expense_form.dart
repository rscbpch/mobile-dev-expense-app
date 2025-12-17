import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseForm extends StatefulWidget {
  final void Function(Expense expense) onAdd;

  const ExpenseForm({super.key, required this.onAdd});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  ExpenseType? selectedCategory;
  DateTime? selectedDate;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Input Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void submit() {
    final title = titleController.text.trim();
    final amountText = amountController.text.trim();

    if (title.isEmpty) {
      _showErrorDialog("Please enter a title.");
      return;
    }

    final amount = double.tryParse(amountText);
    if (amountText.isEmpty || amount == null || amount <= 0) {
      _showErrorDialog("Please enter a valid number for amount.");
      return;
    }

    if (selectedDate == null) {
      _showErrorDialog("Please select a date.");
      return;
    }

    if (selectedCategory == null) {
      _showErrorDialog("Please select a category.");
      return;
    }

    final newExpense = Expense(
      title: title,
      amount: amount,
      date: selectedDate!,
      category: selectedCategory!,
    );

    widget.onAdd(newExpense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedDate == null
                                ? 'No date selected'
                                : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          DropdownButton<ExpenseType>(
            hint: const Text('Select category'),
            value: selectedCategory,
            isExpanded: true,
            items: ExpenseType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(type.name),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                selectedCategory = val;
              });
            },
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: submit,
                child: const Text('Create'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}