import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'griddashboard.dart';

class GridPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GridPageState();
  }
}

class GridPageState extends State<GridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        SizedBox(
          height: 110,
        ),
        GridDashboard()
      ]),
    );
  }
}
