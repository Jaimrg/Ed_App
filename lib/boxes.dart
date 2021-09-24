import 'package:hive/hive.dart';
import 'package:ed_app/model/Estudante.dart';

class Boxes {
  static Box<Estudante> getTransactions() => Hive.box<Estudante>('Estudante');
}
