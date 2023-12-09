import 'package:flutter/material.dart';
import 'package:expense_tracker/Model/expenses.dart';

class DisplayList extends StatelessWidget {
  const DisplayList(
      {super.key, required this.addedexpenses, required this.onRemoveExpense});

  final List<Expense> addedexpenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: addedexpenses.length,
        itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(addedexpenses[index]),
              onDismissed: (direction) {
                onRemoveExpense(addedexpenses[index]);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(addedexpenses[index].title),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('\$${addedexpenses[index].amount.toString()}'),
                          const Spacer(),
                          Expanded(
                            child: Row(
                              children: [
                                //  Icon(categoryIcons[addedexpenses[index].category]),
                                Icon(categoryIcons[
                                    addedexpenses[index].category]),

                                const SizedBox(
                                  width: 5,
                                ),
                                Text(addedexpenses[index].dateformatter),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
