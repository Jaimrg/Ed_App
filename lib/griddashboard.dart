// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'form_screen.dart';
import 'data_show.dart';
import 'package:hive/hive.dart';
import 'package:ed_app/model/Estudante.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:ed_app/screens/calendar_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ed_app/util/database.dart';
import 'package:ed_app/show_data.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Cadastrar",
      //subtitle: "March, Wednesday",
      //event: "3 Events",
      img: "assets/add.png");

  Items item2 = new Items(
    title: "Listagem",
    // subtitle: "Bocali, Apple",
    //event: "4 Items",
    img: "assets/examination.png",
  );
  Items item3 = new Items(
    title: "Ajustes",
    //subtitle: "Lucy Mao going to Office",
    //event: "",
    img: "assets/settings.png",
  );
  Items item4 = new Items(
    title: "Agendamentos",
    // subtitle: "Rose favirited your Post",
    //event: "",
    img: "assets/calendar_2.png",
  );

  final FocusNode _uidFocusNode = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4];
    var color = 0xFFFFFF; //0xff453658;
    return Expanded(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return Container(
                decoration: BoxDecoration(
                  color: Color(color),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 1),
                        blurRadius: 2.0)
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Material(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: () async {
                          if (data.title == "Cadastrar") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new FormScreen(
                                        focusNode: _uidFocusNode)));

                            ;
                            print("ola");
                          }

                          if (data.title == "Listagem") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new StudentList()));
                          }

                          if (data.title == "Ajustes") {
                            /*await Database.addEstudante(
                                nome: "Luis", estado: "Pago");
                            print('ajustes');*/
                          }

                          if (data.title == "Agendamentos") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new CalendarPage()));
                          }
                        },
                        splashColor: Colors.red,
                        splashFactory: InkSplash.splashFactory,
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                data.img,
                                width: 42,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                data.title,
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              /*Text(
                                data.subtitle,
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        color: Colors.white38,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600)),
                              ),*/
                              SizedBox(
                                height: 14,
                              ),
                              /*Text(
                                data.event,
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600)),
                              ),*/
                            ],
                          ),
                        ))));
          }).toList()),
    );
  }
}

class Items {
  String title;
  //String subtitle;
  //String event;
  String img;
  Items(
      {required this.title,
      // required this.subtitle,
      // required this.event,
      required this.img});
}
