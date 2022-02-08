import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('alunos');

class Database {
  static String? userUid;
  static addAluno(String nome, String bairro, String telefone,
      String telefone_enc, String classe) {
    Map<String, dynamic> dados = {
      "nome": nome,
      "bairro": bairro,
      "telefone": telefone,
      "telefone_enc": telefone_enc,
      "classe": classe
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('explicandos');
    collectionReference.add(dados);
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference estCollection =
        _mainCollection.doc(userUid).collection('alunos');

    return estCollection.snapshots();
  }

  static Future<void> addEstudante({
    required String nome,
    required String estado,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('estudantes').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nome": nome,
      "estado": estado,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Student added to the database"))
        .catchError((e) => print(e));
  }

  static getUsers() {
    return FirebaseFirestore.instance.collection('alunos').snapshots();
  }
}
