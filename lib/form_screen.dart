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
import 'data_show.dart';
import 'package:intl/intl.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  //Variaveis

  var now = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');

  late String _classe;
  List _classes = [
    '1ª a 7ª Classes',
    '8ª a 10ª Classes',
    '11ª e 12ª Classes',
    'Preparação Para Exames',
    'Ensino Médio',
    'Ensino Superior'
  ];

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

  //Hive_Salvar Dados

  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  //late String value;

  final topBar = new AppBar(
    backgroundColor: Colors.white,
    // centerTitle: true,
    elevation: 0.0,
    //leading: new Icon(Icons.arrow_back_ios, color: Colors.black),
    actions: <Widget>[
      Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 19.0),
          child: new Text(
            "Cadastro",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.normal,
                fontFamily: 'arial'),
          ))
    ],
  );

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
              addEstudante(
                  nome_f, bairro, contacto, contacto_enc, _currentSugars!);
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

  void setDados(
      String nomeD, String bairroD, String contactoD, String contacto_encD) {
    nome.text = nomeD;
    bairroC.text = bairroD;
    telefone.text = contactoD;
    telefone_enc.text = contacto_encD;
  }

  var selectedCurrency, selectedType;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  final sugars = [
    '1ª a 7ª Classes',
    '8ª a 10ª Classes',
    '11ª e 12ª Classes',
    'Preparação Para Exames',
    'Ensino Médio',
    'Ensino Superior'
  ];
  String? _currentSugars = '1ª a 7ª Classes';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: topBar,
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.all(24),
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildName(),
                          _buildBairro(),
                          _buildTelefone(),
                          _buildTelefone_Enc(),
                          SizedBox(height: 30),
                          /*Container(
                            child: DropdownButton(
                          hint: Text('Classe'),
                          value: _classe,
                          items: _classes.map((value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                               _classe = value;
                            });
                          },
                        ))*/

                          DropdownButtonFormField<String>(
                            value: _currentSugars,
                            // decoration: const textInputDecoration,
                            items: sugars.map((sugar) {
                              return DropdownMenuItem(
                                value: sugar,
                                child: Text(sugar),
                              );
                            }).toList(),
                            onChanged: (val) =>
                                setState(() => _currentSugars = val),
                          ),
                          SizedBox(height: 30),
                          Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            padding: EdgeInsets.only(right: 16.0, left: 16.0),
                            child: buildSubmit(),
                          )
                          /*Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            padding: EdgeInsets.only(right: 16.0, left: 16.0),
                            
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              onPressed: () {
                                List<Info_Aluno> infoaluno = [];

                                /*void initData(int size) {
                                  for (int i = 0; i < size; i++) {
                                    infoaluno.add(Info_Aluno(
                                        "Jaime",
                                        i % 2 == 0,
                                        "10",
                                        "Ndlavela",
                                        "8483883828",
                                        "8737363535",
                                        "10/09/2021",
                                        1500));
                                  }
                                }*/

                                AlertDialog(
                                  // Retrieve the text the user has entered by using the
                                  // TextEditingController.
                                  content: Text(nome.text),
                                );
                              },
                              color: Colors.blue[300],
                              child: Text(
                                "Cadastrar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Raleway',
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          )*/
                        ])))),
        bottomNavigationBar: new Container(
          color: Colors.white,
          height: 50.0,
          alignment: Alignment.center,
          child: new BottomAppBar(
            child: new Row(
              // alignment: MainAxisAlignment.spaceAround,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new TextButton.icon(
                  icon: Icon(Icons.group_add_rounded),
                  label: Text('Adicionar Aluno'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new FormScreen()),
                    );
                  },
                ),
                /* new IconButton(
                  icon: Icon(
                    Icons.question_answer,
                  ),
                  onPressed: null,
                ),
                new IconButton(
                  icon: Icon(
                    Icons.book,
                  ),
                  onPressed: null,
                ),*/
                new TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  icon: Icon(
                    Icons.article_outlined,
                    color: Colors.black,
                  ),
                  label: Text('Visualizar Alunos'),
                  onPressed: () {
                    Hive.openBox<Estudante>('Estudante');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new TransactionPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Future addEstudante(String nome, String bairro, String telefone,
      String telefone_enc, String classe) async {
    String formattedDate = formatter.format(now);
    final estudante = Estudante()
      ..nome = nome
      ..estado = true
      ..classe = classe
      ..bairro = bairro
      ..telefone = telefone
      ..telefone_enc = telefone_enc
      ..data_pagamento = formattedDate
      ..valor = valor(classe);
    final box = Boxes.getTransactions();
    box.add(estudante);
    //box.put('mykey', transaction);

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
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
