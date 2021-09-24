import 'dart:convert';

import 'package:flutter/material.dart';
import 'data_table.dart';
import 'model/Info_Aluno.dart';
import 'model/Aluno.dart';
import 'widget/button_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'boxes.dart';
import 'package:intl/intl.dart';
//
import 'package:ed_app/model/Estudante.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ed_app/widget/transaction_dialog.dart';
import 'package:ed_app/widget/ver_mais.dart';
import 'form_screen.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  /*@override
  void dispose() {
    Hive.close();

    super.dispose();
  }*/
  final topBar = new AppBar(
    backgroundColor: Colors.blue,
    // centerTitle: true,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.white, //change your color here
    ),
    //leading: new Icon(Icons.arrow_back_ios, color: Colors.black),
    actions: <Widget>[
      Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 19.0),
          child: new Text(
            "Lista de Alunos",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.normal,
              fontFamily: 'arial',
            ),
          ))
    ],
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: topBar,
        /*AppBar(
          title: Text('Lista De Alunos'),
          centerTitle: true,
        ),*/
        body: ValueListenableBuilder<Box<Estudante>>(
          valueListenable: Boxes.getTransactions().listenable(),
          builder: (context, box, _) {
            final box = Boxes.getTransactions();
            final transactions = box.values.toList().cast<Estudante>();

            return buildContent(transactions);
          },
        ),
        /*floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => TransactionDialog(
              onClickedDone: addTransaction,
            ),
          ),
        ),*/
      );

  Widget buildContent(List<Estudante> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'Sem Alunos Registrados',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      /* final netExpense = transactions.fold<double>(
        0,
        (previousValue, transaction) => transaction.isExpense
            ? previousValue - transaction.amount
            : previousValue + transaction.amount,
      );
      final newExpenseString = '\$${netExpense.toStringAsFixed(2)}';
      final color = netExpense > 0 ? Colors.green : Colors.red;*/

      return Column(
        children: [
          SizedBox(height: 24),
          /* Text(
            'Net Expense: $newExpenseString',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: color,
            ),
          ),*/
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = transactions[index];

                return buildTransaction(context, transaction);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTransaction(
    BuildContext context,
    Estudante transaction,
  ) {
    /*final color = transaction.isExpense ? Colors.red : Colors.green;
    final date = DateFormat.yMMMd().format(transaction.createdDate);*/
    final amount = transaction.valor.toStringAsFixed(2) + ' \MT';
    // String valor = toString(transaction.valor);
    final color = Colors.green;

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          transaction.nome,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          transaction.bairro +
              "\n" +
              transaction.data_pagamento +
              "\n" +
              transaction.classe +
              "\n" +
              transaction.telefone +
              "\n" +
              transaction.telefone_enc,
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
        ),
        trailing: Text(
          amount,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          buildButtons(context, transaction),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Estudante transaction) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Renovar'),
              icon: Icon(Icons.more_vert),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VerMaisDialog(
                    estudante: transaction,
                    onClickedDone: (name, amount, isExpense) => print('edited'),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
                label: Text('Editar'),
                icon: Icon(Icons.edit),
                onPressed: () {
                  FormScreen fs = new FormScreen();
                }),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Excluir'),
              icon: Icon(Icons.delete),
              onPressed: () => deleteTransaction(transaction),
            ),
          )
        ],
      );

  Future addEstudante(String nome, String bairro, String telefone,
      String telefone_enc, String classe) async {
    final estudante = Estudante()
      ..nome = nome
      ..estado = true
      ..classe = classe
      ..bairro = bairro
      ..telefone = telefone
      ..telefone_enc = telefone_enc
      ..data_pagamento = '10/09'
      ..valor = 1000;
    final box = Boxes.getTransactions();
    box.add(estudante);
    //box.put('mykey', transaction);

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  void deleteTransaction(Estudante transaction) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);

    transaction.delete();
    //setState(() => transactions.remove(transaction));
  }
}
