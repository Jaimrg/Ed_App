// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Estudante.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EstudanteAdapter extends TypeAdapter<Estudante> {
  @override
  final int typeId = 0;

  @override
  Estudante read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Estudante()
      ..nome = fields[0] as String
      ..estado = fields[1] as bool
      ..classe = fields[2] as String
      ..bairro = fields[3] as String
      ..telefone = fields[4] as String
      ..telefone_enc = fields[5] as String
      ..data_pagamento = fields[6] as String
      ..valor = fields[7] as double;
  }

  @override
  void write(BinaryWriter writer, Estudante obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.estado)
      ..writeByte(2)
      ..write(obj.classe)
      ..writeByte(3)
      ..write(obj.bairro)
      ..writeByte(4)
      ..write(obj.telefone)
      ..writeByte(5)
      ..write(obj.telefone_enc)
      ..writeByte(6)
      ..write(obj.data_pagamento)
      ..writeByte(7)
      ..write(obj.valor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EstudanteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
