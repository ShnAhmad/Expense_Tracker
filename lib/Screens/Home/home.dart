import 'package:expense_tracker/Model/expenses.dart';
import 'package:expense_tracker/Screens/Home/displaylist.dart';
import 'package:expense_tracker/Screens/NewExpense/newexpense.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Expense> addedexpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 1500,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
      title: 'Java Course',
      amount: 1450,
      category: Category.work,
      date: DateTime.now(),
    ),
  ];

  void _openaddexpenseoverlay() {
    showModalBottomSheet(
        context: context, builder: (ctx) => const NewExpense());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: _openaddexpenseoverlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          const Text('Chart'),
          DisplayList(addedexpenses: addedexpenses),
          // ...addedexpenses.map((item) => Column(
          //       children: [
          //         Text(item.title),
          //         Text(item.title),
          //       ],
          //     ))
        ],
      ),
    );
  }
}
