import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'griddashboard.dart';
import 'grid_page.dart';
import 'package:hive/hive.dart';
import 'package:ed_app/model/Estudante.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 15,
            backgroundColor: Colors.blue,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(150),
              child: SizedBox(),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    bottomRight: Radius.circular(90)))),
        body: Column(
          children: <Widget>[
            SizedBox(height: 39),
            Expanded(child: GridDashboard()),
          ],
        ));
  }
}
