// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace, deprecated_member_use

import 'package:despesas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(
    this.transactions,
    this.onRemove,
  );

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
    // Esse Layoutbuilder determina o que deve ser exibido na tela caso a lista de transações estiver vazia
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Nenhuma Transação Cadastrada!',
                  style: TextStyle(fontFamily: 'BigShouldersStencilDisplay'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/money.gif',
                    fit: BoxFit.cover,
                  ),
                ),
              ]);
            },
          )
        // Esse Listview constroi a lista de transações caso ela não esteja vazia e determina qual o estilo que a lista e seus componentes devem ser exibidos
        : ListView.builder(
            itemCount: transactions
                .length, // O item count e builder fazem com que a lista não fique toda carregada e sim que carregue o que é visto na tela
            itemBuilder: ((ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent[100],
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('R\$${tr.value}'),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: TextStyle(fontFamily: 'NixieOne'),
                  ),
                  subtitle: Text(
                    DateFormat('d/MMMM/y').format(tr.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 480
                      ? FlatButton.icon(
                          onPressed:(() => onRemove(tr.id)),
                          icon: Icon(Icons.delete),
                          label: Text('Excluir'),
                          textColor: Colors.red,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: (() => onRemove(tr.id)),
                        ),
                ),
              );
            }),
          );
  }
}
