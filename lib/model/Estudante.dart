import 'package:hive/hive.dart';
part 'Estudante.g.dart';

@HiveType(typeId: 0)
class Estudante extends HiveObject {
  @HiveField(0)
  late String nome;

  @HiveField(1)
  late bool estado;

  @HiveField(2)
  late String classe;

  @HiveField(3)
  late String bairro;

  @HiveField(4)
  late String telefone;

  @HiveField(5)
  late String telefone_enc;

  @HiveField(6)
  late String data_pagamento;

  @HiveField(7)
  late double valor;
}
