import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Info_Aluno {
  String nome;
  bool estado;
  String classe;
  String bairro;
  String telefone;
  String telefone_enc;
  String data_pagamento;
  double valor;

  Info_Aluno(
      {required this.nome,
      required this.estado,
      required this.classe,
      required this.bairro,
      required this.telefone,
      required this.telefone_enc,
      required this.data_pagamento,
      required this.valor});

  Map<String, dynamic> toJson() => {
        'Nome': nome,
        'Estado': estado,
        'Classe': classe,
        'Bairro': bairro,
        'Telefone': telefone,
        'Telefone_Enc': telefone_enc,
        'Data Pagamento': data_pagamento,
        'Valor': valor,
      };

  factory Info_Aluno.fromJson(Map<String, dynamic> jsonData) {
    return Info_Aluno(
        nome: jsonData['nome'] ?? 0,
        estado: jsonData['estado'] ?? 0,
        classe: jsonData['classe'] ?? 0,
        bairro: jsonData['bairro'] ?? 0,
        telefone: jsonData['telefone'] ?? 0,
        telefone_enc: jsonData['telefone_enc'] ?? 0,
        data_pagamento: jsonData['data_pagamento'] ?? 0,
        valor: jsonData['valor'] ?? 0);
  }

  static String encode(List<Info_Aluno> alunos) => json.encode(
        alunos
            .map<Map<String, dynamic>>((alunos) => Info_Aluno.toMap(alunos))
            .toList(),
      );

  static List<Info_Aluno> decode(String alunos) =>
      (json.decode(alunos) as List<dynamic>)
          .map<Info_Aluno>((item) => Info_Aluno.fromJson(item))
          .toList();

  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String alunoEncoded = Info_Aluno.encode([
      Info_Aluno(
          nome: 'Jaime',
          estado: true,
          classe: '12',
          bairro: 'Ndlavela',
          telefone: '8548483832',
          telefone_enc: '873645342',
          data_pagamento: '10/0/2001',
          valor: 10000),
    ]);
    /*final alunoEncoded = Info_Aluno(
        nome: 'Jaime',
        estado: true,
        classe: '12',
        bairro: 'Ndlavela',
        telefone: '8548483832',
        telefone_enc: '873645342',
        data_pagamento: '10/0/2001',
        valor: 10000);*/
    final List<Info_Aluno> decodedData = Info_Aluno.decode(alunoEncoded);
    String json = jsonEncode(alunoEncoded);
    print(json);
    print('ola jaime');
    prefs.setString('aluno_key', json);
    //lista(decodedData);
  }

  clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    print("Dados Apagados");
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? json = prefs.getString('aluno_key');
    print('Loaded $json');

    if (json == null) {
      print('null');
    } else {
      Map<String, dynamic> nap = jsonDecode(json);
    }
  }

  static toMap(Info_Aluno alunos) {}

  List<Info_Aluno> lista(List<Info_Aluno> lista) {
    return lista;
  }
}
