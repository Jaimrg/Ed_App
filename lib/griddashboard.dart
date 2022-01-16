import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Calendar",
      subtitle: "March, Wednesday",
      event: "3 Events",
      img: "assets/calendar.png");

  Items item2 = new Items(
    title: "Groceries",
    subtitle: "Bocali, Apple",
    event: "4 Items",
    img: "assets/food.png",
  );
  Items item3 = new Items(
    title: "Locations",
    subtitle: "Lucy Mao going to Office",
    event: "",
    img: "assets/map.png",
  );
  Items item4 = new Items(
    title: "Activity",
    subtitle: "Rose favirited your Post",
    event: "",
    img: "assets/festival.png",
  );
  Items item5 = new Items(
    title: "To do",
    subtitle: "Homework, Design",
    event: "4 Items",
    img: "assets/todo.png",
  );
  Items item6 = new Items(
    title: "Settings",
    subtitle: "",
    event: "2 Items",
    img: "assets/setting.png",
  );

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
                        onTap: () {},
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
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                data.subtitle,
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        color: Colors.white38,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                data.event,
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ))));
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items(
      {required this.title,
      required this.subtitle,
      required this.event,
      required this.img});
}
