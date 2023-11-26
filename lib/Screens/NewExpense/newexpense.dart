import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selectedDate;

  void _showDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _titlecontroller,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountcontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefix: Text('\$'),
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Date Selected'
                        : DateFormat.yMd().format(_selectedDate!).toString(),
                  ),
                  IconButton(
                    onPressed: _showDate,
                    icon: const Icon(Icons.calendar_today),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Save Expense'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
