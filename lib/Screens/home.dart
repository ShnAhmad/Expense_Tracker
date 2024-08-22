import 'package:expense_tracker/Model/expenses.dart';
import 'package:expense_tracker/Screens/newexpense.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Expense> addedexpenses = [];

  void _openaddexpenseoverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: addNewExpense),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
    );
  }

  void addNewExpense(Expense expense) {
    setState(() {
      addedexpenses.add(expense);
    });
  }

  void removeNewExpense(Expense expense) {
    final expenseIndex = addedexpenses.indexOf(expense);
    setState(() {
      addedexpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              addedexpenses.insert(expenseIndex, expense);
            });
          },
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text(
        "No Expenses",
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: Colors.grey),
      ),
    );

    if (addedexpenses.isNotEmpty) {
      mainContent = DisplayList(
        addedexpenses: addedexpenses,
        onRemoveExpense: removeNewExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
        ),
        child: Column(
          children: [
            Expanded(child: mainContent),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openaddexpenseoverlay,
        tooltip: 'Add Expense',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DisplayList extends StatelessWidget {
  const DisplayList({
    super.key,
    required this.addedexpenses,
    required this.onRemoveExpense,
  });

  final List<Expense> addedexpenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addedexpenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.8),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        key: ValueKey(addedexpenses[index]),
        onDismissed: (direction) {
          onRemoveExpense(addedexpenses[index]);
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  addedexpenses[index].title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$${addedexpenses[index].amount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          categoryIcons[addedexpenses[index].category],
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          addedexpenses[index].dateformatter,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
