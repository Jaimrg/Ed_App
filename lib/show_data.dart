import 'package:ed_app/util/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

class StudentList extends StatelessWidget {
  final db = FirebaseFirestore.instance;

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
                                          .substring(1, 10),
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
                                  buildButtons(context, docID.toString(),
                                      snapshot.data?.docs[index].reference),
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
}

class MatchModel {}

Widget buildButtons(BuildContext context, String docId,
        DocumentReference<Object?>? reference) =>
    Row(
      children: [
        Expanded(
          child: TextButton.icon(
            label: Text('Mais'),
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: TextButton.icon(
            label: Text('Editar'),
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: TextButton.icon(
            label: Text('Excluir'),
            icon: Icon(Icons.delete),
            onPressed: () {
              debugPrint("Cheguei!");
              print("Doc ID: " + docId);
              Database.deleteItem(docId: docId, reference: reference);
            },
          ),
        )
      ],
    );
