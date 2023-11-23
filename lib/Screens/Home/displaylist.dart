import 'package:flutter/material.dart';
import 'package:expense_tracker/Model/expenses.dart';

class DisplayList extends StatelessWidget {
  const DisplayList({super.key, required this.addedexpenses});

  final List<Expense> addedexpenses;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: addedexpenses.length,
          itemBuilder: (ctx, index) => Card(
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
                          Row(
                            children: [
                              //  Icon(categoryIcons[addedexpenses[index].category]),
                              Icon(
                                  categoryIcons[addedexpenses[index].category]),

                              const SizedBox(
                                width: 5,
                              ),
                              Text(addedexpenses[index].dateformatter),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
