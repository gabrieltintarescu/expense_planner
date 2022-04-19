// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height - 210,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: ((context, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  FittedBox(
                    child: Text(
                      'No transactions yet!',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Lottie.network(
                          'https://assets6.lottiefiles.com/packages/lf20_a7vr2ghs.json')),
                ],
              );
            }))
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              '\$${transactions[index].amount}',
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: MediaQuery.of(context).size.width > 400
                          ? TextButton.icon(
                              onPressed: () => deleteTx(transactions[index].id),
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                              ),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).primaryColor,
                              onPressed: () => deleteTx(transactions[index].id),
                            ),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
