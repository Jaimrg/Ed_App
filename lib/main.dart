import 'package:flutter/material.dart';
import 'form_screen.dart';
import 'package:hive/hive.dart';
import 'package:ed_app/model/Estudante.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'data_show.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(EstudanteAdapter());
  await Hive.openBox<Estudante>('Estudante');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ED_app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormScreen(),
    );
  }
}
