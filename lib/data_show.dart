import 'dart:convert';

import 'package:flutter/material.dart';
import 'data_table.dart';
import 'model/Info_Aluno.dart';
import 'model/Aluno.dart';
import 'widget/button_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'boxes.dart';

//
import 'package:ed_app/model/Estudante.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ed_app/widget/transaction_dialog.dart';
import 'package:ed_app/widget/ver_mais.dart';
import 'widget/EditDialog.dart';
import 'package:intl/intl.dart';

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
    backgroundColor: Colors.white,
    // centerTitle: true,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.blue, //change your color here
    ),
    //leading: new Icon(Icons.arrow_back_ios, color: Colors.black),
    actions: <Widget>[
      Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 19.0),
          child: new Text(
            "Lista de Alunos",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.normal,
              fontFamily: 'arial',
            ),
          ))
    ],
  );

  late String _classe;
  List _classes = [
    '1ª a 7ª Classes',
    '8ª a 10ª Classes',
    '11ª e 12ª Classes',
    'Preparação Para Exames',
    'Ensino Médio',
    'Ensino Superior'
  ];
  final sugars = [
    '1ª a 7ª Classes',
    '8ª a 10ª Classes',
    '11ª e 12ª Classes',
    'Preparação Para Exames',
    'Ensino Médio',
    'Ensino Superior'
  ];
  String? _currentSugars = '1ª a 7ª Classes';
  TextEditingController nome = new TextEditingController();
  TextEditingController bairroC = new TextEditingController();
  TextEditingController telefone = new TextEditingController();
  TextEditingController telefone_enc = new TextEditingController();
  String name = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nome_f = '';
  String bairro = '';
  String contacto = '';
  String contacto_enc = '';
  String classe = '';

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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
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
              onPressed: () {
                _RenovarDialog(context, transaction);
              },
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Editar'),
              icon: Icon(Icons.edit),
              onPressed: () {
                /*Navigator.push(
                  contexta,
                  new MaterialPageRoute(
                    builder: (contexta) => EditDialog(
                      estudante: transaction,
                      contexto: context,
                      onClickedDone:
                          (nome, bairro, telefone, telefone_enc, contexta) =>
                              editEstudante(transaction, nome, bairro, telefone,
                                  telefone_enc, classe),
                    ),
                  ),
                );*/
                if (transaction != null) {
                  nome.text = transaction.nome;
                  bairroC.text = transaction.bairro;
                  telefone.text = transaction.telefone;
                  telefone_enc.text = transaction.telefone;
                }
                _EditarDialog(context, transaction);
              },
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Excluir'),
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteDialog(context, transaction);
              },
            ),
          )
        ],
      );

  _deleteDialog(BuildContext context, Estudante transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text('Confirmacao'),
            content: Text(
                'Tem Certeza que Pretende Excluir ' + transaction.nome + '?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  deleteEstudante(transaction);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Sim',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _RenovarDialog(BuildContext context, Estudante transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text('Confirmacao'),
            content: Text(
                'Confirmar a Renovacao do Pacote da ' + transaction.classe),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Nao',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Sim',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /*_EditarDialog(BuildContext context, Estudante transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text('Confirmacao'),
            content: Form(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 8),
                    _buildName(),
                    SizedBox(height: 8),
                    _buildBairro(),
                    SizedBox(height: 8),
                    _buildTelefone(),
                    SizedBox(height: 8),
                    _buildTelefone_Enc(),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _currentSugars,
                      // decoration: const textInputDecoration,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text(sugar),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugars = val),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();

                  if (isValid) {
                    _formKey.currentState!.save();

                    // editEstudante(transaction, nome_f, bairro, contacto,
                    //contacto_enc, classe);

                  }
                  print("Nome do puto " + nome_f);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Atualizar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }*/

  _EditarDialog(BuildContext context, Estudante transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text('Confirmacao'),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 8),
                    _buildName(),
                    SizedBox(height: 8),
                    _buildBairro(),
                    SizedBox(height: 8),
                    _buildTelefone(),
                    SizedBox(height: 8),
                    _buildTelefone_Enc(),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _currentSugars,
                      // decoration: const textInputDecoration,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text(sugar),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugars = val),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              buildAddButton(context, transaction),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context, Estudante transaction) {
    return TextButton(
      child: Text('Atualizar'),
      onPressed: () async {
        final isValid = _formKey.currentState!.validate();

        if (isValid) {
          final nomeb = nome.text;
          final bairro = bairroC.text;
          final telefoneb = telefone.text;
          final telefone_encb = telefone_enc.text;

          /*EditDialog.onClickedDone(
              nomeb, bairro, telefoneb, telefone_encb, context);*/
          editEstudante(transaction, nomeb, bairro, telefoneb, telefone_encb,
              _currentSugars!);
          Navigator.of(context).pop();
        }
      },
    );
  }

  void setDados(
      String nomeD, String bairroD, String contactoD, String contacto_encD) {
    nome.text = nomeD;
    bairroC.text = bairroD;
    telefone.text = contactoD;
    telefone_enc.text = contacto_encD;
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nome'),
      maxLength: 20,
      controller: nome,
      validator: (value) {
        if (value!.length < 2) {
          return 'Digite Pelomenos 2 Caracteres';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() => nome_f = value.toString()),
    );
  }

  Widget _buildBairro() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Bairro'),
      maxLength: 20,
      controller: bairroC,
      validator: (value) {
        if (value!.length < 2) {
          return 'Digite Pelomenos 2 Caracteres';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() => bairro = value.toString()),
    );
  }

  Widget _buildTelefone() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Contacto'),
      maxLength: 10,
      controller: telefone,
      validator: (value) {
        if (value!.length < 9) {
          return 'Digite Pelo menos 9 Digitos';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      onSaved: (value) => setState(() => contacto = value.toString()),
    );
  }

  Widget _buildTelefone_Enc() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Contacto Do Encarregado'),
      maxLength: 10,
      controller: telefone_enc,
      validator: (value) {
        if (value!.length < 9) {
          return 'Digite Pelo menos 9 Digitos';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      onSaved: (value) => setState(() => contacto_enc = value.toString()),
    );
  }

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
          text: 'Cadastrar',
          onClicked: () {
            final isValid = _formKey.currentState!.validate();
            // FocusScope.of(context).unfocus();

            if (isValid) {
              _formKey.currentState!.save();

              final message = 'Cadastrado Com Sucesso';
              final snackBar = SnackBar(
                content: Text(
                  message,
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.green,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              Aluno al = new Aluno();
              al.initData(0, nome_f, bairro, contacto, contacto_enc);
              clean();
              addEstudante(nome_f, bairro, contacto, contacto_enc, classe);
            }
          },
        ),
      );

  void clean() {
    nome.clear();
    bairroC.clear();
    telefone.clear();
    telefone_enc.clear();
  }

  //metodos para o CRUD

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

  void deleteEstudante(Estudante transaction) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);

    transaction.delete();
    //setState(() => transactions.remove(transaction));
  }

  void editEstudante(
    Estudante transaction,
    String nome,
    String bairro,
    String telefone,
    String telefone_enc,
    String classe,
  ) {
    transaction.nome = nome;
    transaction.bairro = bairro;
    transaction.telefone = telefone;
    transaction.telefone_enc = telefone_enc;
    transaction.classe = classe;
    transaction.valor = valor(classe);
    // final box = Boxes.getTransactions();
    // box.put(transaction.key, transaction);

    transaction.save();
  }

  double valor(String classe) {
    if (classe == '1ª a 7ª Classes') {
      return 250;
    }

    //
    if (classe == '8ª a 10ª Classes') {
      return 250;
    }
    //
    if (classe == '11ª e 12ª Classes') {
      return 300;
    }
    if (classe == 'Preparação Para Exames') {
      return 300;
    }
    //
    if (classe == 'Ensino Médio') {
      return 400;
    }
    //
    if (classe == 'Ensino Superior') {
      return 650;
    }
    return 200;
  }
}
