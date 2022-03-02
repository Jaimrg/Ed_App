import 'package:flutter/material.dart';
import 'package:ed_app/dates_list.dart';
import 'package:ed_app/theme/colors/light_colors.dart';
import 'package:ed_app/widget/calendar_dates.dart';
import 'package:ed_app/widget/task_container.dart';
import 'package:ed_app/screens/create_new_task_page.dart';
import 'package:ed_app/widget/back_button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localization/localization.dart';

class CalendarPage extends StatefulWidget {
  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  late Map<DateTime, List<dynamic>> _events;
  late List<dynamic> _selectedEvents;
  late TextEditingController _eventController;
  late SharedPreferences prefs;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  Widget _dashedText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        '------------------------------------------',
        maxLines: 1,
        style:
            TextStyle(fontSize: 20.0, color: Colors.black12, letterSpacing: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: LightColors.kLightYellow,
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),
          child: Column(
            children: <Widget>[
              MyBackButton(),
              SizedBox(height: 30.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 40.0,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(35, 156, 187, 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateNewTaskPage(),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            '+ Actividade',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ]),
              SizedBox(height: 10),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Productive Day, Sourav',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Fevereiro, 2022',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),*/
              //SizedBox(height: 20.0),
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TableCalendar(
                        locale: Localizations.localeOf(context).languageCode,
                        calendarFormat: CalendarFormat.week,
                        firstDay: DateTime.utc(2021, 1, 1),
                        focusedDay: _focusedDay,
                        lastDay: DateTime.utc(2025, 1, 1),
                      )
                    ]),
                /*child: Row(children: <Widget>[
                  TableCalendar(
                    calendarFormat: CalendarFormat.week,
                    firstDay: DateTime.utc(2021, 1, 1),
                    focusedDay: _focusedDay,
                    lastDay: DateTime.utc(2025, 1, 1),
                  )
                ]),*/
                /* height: 58.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CalendarDates(
                      day: days[index],
                      date: dates[index],
                      dayColor: index == 0 ? LightColors.kRed : Colors.black54,
                      dateColor:
                          index == 0 ? LightColors.kRed : LightColors.kDarkBlue,
                    );
                  },
                ),*/
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ListView.builder(
                            itemCount: time.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${time[index]} ${time[index] > 8 ? 'PM' : 'AM'}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 5,
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              _dashedText(),
                              TaskContainer(
                                title: 'Aulas A Domicilio',
                                subtitle: 'Aulas No Bairro Khongolote',
                                boxColor: LightColors.kPalePink,
                              ),
                              _dashedText(),
                              TaskContainer(
                                title: 'Aula de Alfabetizacao',
                                subtitle: 'Aula Especial',
                                boxColor: LightColors.kLavender,
                              ),
                              TaskContainer(
                                title: 'Aulas A Domicilio',
                                subtitle: 'Aulas No Bairro Mateque',
                                boxColor: LightColors.kPalePink,
                              ),
                              TaskContainer(
                                title: 'Digitacao de Trabalho',
                                subtitle: 'Ajuda na digitacao do trabalho',
                                boxColor: LightColors.kLightGreen,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
