import 'package:ed_app/util/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'widget/button_widget.dart';

class StudentList extends StatefulWidget {
  @override
  StudentListPageState createState() => StudentListPageState();
}

class StudentListPageState extends State<StudentList> {
  final db = FirebaseFirestore.instance;

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

  final classes = [
    '1ª a 7ª Classes',
    '8ª a 10ª Classes',
    '11ª e 12ª Classes',
    'Preparação Para Exames',
    'Ensino Médio',
    'Ensino Superior'
  ];
  String? _currentClasse = '1ª a 7ª Classes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: db.collection('explicandos').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  SizedBox(height: 24),
                  SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          String? docID =
                              snapshot.data?.docs[index].id.toString();
                          snapshot.data?.docs[index].reference.id.toString();
                          return Card(
                              color: Colors.white,
                              child: ExpansionTile(
                                tilePadding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                                title: Text(
                                  snapshot.data?.docs[index]['nome'],
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                subtitle: Text(
                                  snapshot.data?.docs[index]['bairro'] +
                                      "\n" +
                                      snapshot
                                          .data?.docs[index]['data_pagamento']
                                          .toString()
                                          .substring(0, 10),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ),
                                trailing: Text(
                                  "250,00 Mt",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                children: [
                                  buildButtons(
                                      context,
                                      docID.toString(),
                                      snapshot.data?.docs[index].reference,
                                      snapshot.data?.docs[index]['classe']
                                          .toString(),
                                      snapshot.data?.docs[index]['telefone']
                                          .toString(),
                                      snapshot.data?.docs[index]['telefone_enc']
                                          .toString(),
                                      snapshot.data?.docs[index]['nome']
                                          .toString()),
                                ],
                              ));
                          //Dead Code but it can helpme one day then i'll let it here
                          /*(snapshot.data!)docs.map((doc) {
                      String? docID = snapshot.data?.docs[index].id.toString();
                      snapshot.data?.docs[index].reference.id.toString();
                      return Card(
                          color: Colors.white,
                          child: ExpansionTile(
                            tilePadding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                            title: Text(
                              (doc.data().toString().contains('nome')
                                  ? doc.get('nome')
                                  : ''),
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Text(
                              (doc.data().toString().contains('bairro')
                                      ? doc.get('bairro')
                                      : '') +
                                  "\n" +
                                  docID,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 14),
                            ),
                            trailing: Text(
                              "250,00 Mt",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            children: [
                              buildButtons(context, docID!),
                            ],
                          ));
                    }).toList();*/

                          try {
                            var matchList = fetchMatches();
                            return matchList;
                          } catch (Exc) {
                            print(Exc);
                            rethrow;
                          }
                        }),
                  )
                ],
              );
            }
            ;
          }),
    );
  }

  fetchMatches() {}

  //Metodos para UPDATE

  _EditarDialog(BuildContext context, String id) {
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
                      value: _currentClasse,
                      // decoration: const textInputDecoration,
                      items: classes.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text(sugar),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentClasse = val),
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
              buildAddButton(context, id),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context, String id) {
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
          Database.updateEstudantea(
              nome: nomeb,
              bairro: bairro,
              classe: classe,
              telefone: telefoneb,
              telefone_enc: telefone_encb,
              id: id);
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

  //Widgets Internos
  Widget buildButtons(
          BuildContext context,
          String docId,
          DocumentReference<Object?>? reference,
          String? classe,
          String? telefone,
          String? telefone_enc,
          String? nome) =>
      Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Mais'),
              icon: Icon(Icons.more_vert),
              onPressed: () {
                _MaisDialog(context, classe, telefone, telefone_enc);
              },
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Editar'),
              icon: Icon(Icons.edit),
              onPressed: () {
                _EditarDialog(context, docId);
              },
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Excluir'),
              icon: Icon(Icons.delete),
              onPressed: () {
                debugPrint("Cheguei!");
                print("Doc ID: " + docId);
                _deleteDialog(context, nome.toString(), docId, reference);
              },
            ),
          )
        ],
      );
  _deleteDialog(BuildContext context, String nome, String docId,
      DocumentReference<Object?>? reference) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text('Confirmacao'),
            content: Text('Tem Certeza que Pretende Excluir ' + nome + '?'),
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
                  Database.deleteItem(docId: docId, reference: reference);
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

  _MaisDialog(BuildContext context, String? classe, String? telefone,
      String? telefone_enc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text('Outros Dados'),
            content: Text('Nivel: ' +
                classe.toString() +
                '\n\n' +
                'Contacto: ' +
                telefone.toString() +
                '\n\n' +
                'Contacto Alt: ' +
                telefone_enc.toString()),
            actions: [
              /*TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Nao',
                  style: TextStyle(color: Colors.red),
                ),
              ),*/
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MatchModel {}
