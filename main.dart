// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, unused_field, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_print, unused_element, unused_import, sized_box_for_whitespace

import 'package:despesas/components/chart.dart';
import 'package:despesas/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import '/components/transaction_form.dart';
import '/components/transaction_list.dart';
import '/models/transaction.dart';


main()  {
  runApp(ExpensesApp());


}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData.dark(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  //Essa função é criada  com base lista de transações e retorna as transações dos ultimos 7 dias
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  //Essa função é responsável por adicionar as transações criadas pelo usuário na lista de transações, gerando um id aleatório e as demais informações determinadas pelo usuário
  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    //Esse método setstate é responsável por informar a aplicação que o estado interno da lista foi alterado com base na função acima
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).maybePop();
  }

  // Essa função contém um setstate responsável por informar a aplicação que há um item sendo removido da lista
  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  // Essa função é reponsável por criar o modal que irá trazer o transactionForm para que o usuário cadastre uma nova transação
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.blueGrey[800],
      elevation: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
   bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      backgroundColor: Colors.blueGrey[800],
      title: Text(
        "Despesas Pessoais",
        style: TextStyle(
          fontFamily: 'ProductSans',
          fontSize: 25 * mediaQuery.textScaleFactor,
          fontWeight: FontWeight.normal,
        ),
      ),
      // Essa action no appbar é responsável por incluir um botão que ao clicar irá trazer o modal que retorna a transactionForm para o usuário cadastrar uma transação
      actions: [
        IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add)),
            if(isLandscape)
               IconButton(
            onPressed: () {
                setState(() {
                  _showChart = !_showChart;
                });
            },
            icon: Icon(_showChart ? Icons.list: Icons.show_chart))
      ],
    );

    final avaliableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    //O appbar foi criado como variavel para poder calcular sua altura e
    // remover ele da altura disponível

    return Scaffold(
      appBar: appBar,
      // Esse body retorna o gráfico de ultimas transações do componente Chart e a lista de transações do componente transactionList
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           if (_showChart || !isLandscape)
            Container(
                height: avaliableHeight * (isLandscape ? 0.70 : 0.35),
                child: Chart(_recentTransactions)),
           if (!_showChart || !isLandscape)
            Container(
              height: avaliableHeight * (isLandscape ? 1 : 0.65),
              child: TransactionList(_transactions, _removeTransaction),
            ),
          ],
        ),
      ),
      // Esse floatingActionButton retorna a função que irá abrir o modal contendo o transactionForm para o usuário cadastrar uma nova transação
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
