//Importacoes
import 'Info_Aluno.dart';

class Aluno {
  List<Info_Aluno> infoaluno = [];

  void initData(int size, String nome, String bairro, String contacto,
      String contacto_enc) {
    //for (int i = 0; i < size; i++) {
    infoaluno.add(Info_Aluno(nome, 2 % 2 == 0, "10", bairro, contacto,
        contacto_enc, "10/09/2021", 1500));
    //}
  }

  void sortName(bool isAscending) {
    infoaluno.sort((a, b) {
      int aId = int.tryParse(a.nome.replaceFirst('User_', '')) ?? 0;
      int bId = int.tryParse(b.nome.replaceFirst('User_', '')) ?? 0;
      return (aId - bId) * (isAscending ? 1 : -1);
    });
  }

  ///
  /// sort with Status and Name as the 2nd Sort
  void sortStatus(bool isAscending) {
    infoaluno.sort((a, b) {
      if (a.estado == b.estado) {
        int aId = int.tryParse(a.nome.replaceFirst('User_', '')) ?? 0;
        int bId = int.tryParse(b.nome.replaceFirst('User_', '')) ?? 0;
        return (aId - bId);
      } else if (a.estado) {
        return isAscending ? 1 : -1;
      } else {
        return isAscending ? -1 : 1;
      }
    });
  }
}
