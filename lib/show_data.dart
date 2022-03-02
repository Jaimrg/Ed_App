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
              return ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 16.0),
                  itemCount: snapshot.data!.docs.length,
                  padding: EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    // return ListTile(

                    (snapshot.data!).docs.map((doc) {
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
                    }).toList();

                    try {
                      var matchList = fetchMatches();
                      return matchList;
                    } catch (Exc) {
                      print(Exc);
                      rethrow;
                    }
                  });
            }
            ;
          }),
    );
  }

  fetchMatches() {}
}

class MatchModel {}

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
              debugPrint("Cheguei!");
              print("Doc ID:" + docId);
              Database.deleteItem(docId: docId);
            },
          ),
        )
      ],
    );
