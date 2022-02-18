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
        title: Text("Alunos"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('explicandos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(children: [
              SizedBox(height: 24),
              SizedBox(height: 24),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(8),
                  children: (snapshot.data!).docs.map((doc) {
                    String? docID =
                        snapshot.data?.docs[0].reference.id.toString();
                    return Card(
                        color: Colors.white,
                        child: ExpansionTile(
                          tilePadding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
                                (doc.data().toString().contains('bairro')
                                    ? doc.get('bairro')
                                    : ''),
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
                  }).toList(),
                ),
              )
            ]);
          }
        },
      ),
    );
  }
}

Widget buildButtons(BuildContext context, String docId) => Row(
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
              Database.deleteItem(docId: docId);
            },
          ),
        )
      ],
    );
