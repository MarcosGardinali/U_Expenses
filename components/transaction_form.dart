// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, avoid_print, unused_local_variable, unused_element, prefer_const_constructors_in_immutables, unnecessary_null_comparison, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

// A função submitForm irá verificar se todos os campos foram preenchidos para adicionar a transação na lista de transações
  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null){
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

// ShowDatePicker é uma função que retorna o calendário para selecionar a data, informando a data inicial, a primeira data e a ultima data
  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      //Esse setState determina o estado da variavel selecteddate de acordo com a data selecionada no calendário
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          //Essa column contém os Textfield de titulo, valor e data inseridos pelo usuário
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Título:',
                ),
              ),
              //Esse Textfield recebe o valor da transação inserida pelo usuário
              TextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Valor (R\$):',
                ),
              ),
                //Esse container contém a row com a caixa de texto que irá receber a data selecionada de acordo com a função que exibe o calendário
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'Nenhuma data selecionada!'
                          : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'),
                    ),
                    // Esse FlatButton ao clicar retorna a função ShowDatePicker que exibe o calendário
                    FlatButton(
                        onPressed: _showDatePicker,
                        textColor: Colors.purpleAccent[100],
                        child: Text(
                          'Selecionar Data',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                ),
              ),
              //Essa row é uma linha que contém o botão que ao clicar executa a função submitForm, que salva os dados de transação preenchidos no form
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton.icon(
                      onPressed: _submitForm,
                      icon: Icon(Icons.save),
                      textColor: Colors.purpleAccent[100],
                      label: Text(
                        'Nova Transação',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
