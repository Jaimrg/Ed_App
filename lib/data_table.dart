import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'model/Info_Aluno.dart';
import 'model/Aluno.dart';
import 'form_screen.dart';
import 'boxes.dart';

class Datatable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DataTableState();
  }
}

class DataTableState extends State<Datatable> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();
  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;

  final topBar = new AppBar(
    backgroundColor: Colors.white,
    // centerTitle: true,
    elevation: 0.0,
    //leading: new Icon(Icons.arrow_back_ios, color: Colors.black),
    /*title: new Padding(
      //height: 35.0,
      padding: const EdgeInsets.only(left: 175.0),
      child: new Text("CADASTRAR"),
      
    ),*/
    actions: <Widget>[
      Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 19.0),
          child: new Text(
            "Lista",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.normal,
                fontFamily: 'AkayaTelivigala'),
          ))
    ],
  );

  /*@override
  void initState() {
    aluno.initData(2);
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: topBar,
        body: _getBodyWidget(),
        bottomNavigationBar: new Container(
          color: Colors.white,
          height: 50.0,
          alignment: Alignment.center,
          child: new BottomAppBar(
            child: new Row(
              // alignment: MainAxisAlignment.spaceAround,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  icon: Icon(Icons.group_add_rounded, color: Colors.black),
                  label: Text('Adicionar Aluno'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new FormScreen()),
                    );
                  },
                ),
                /* new IconButton(
                  icon: Icon(
                    Icons.question_answer,
                  ),
                  onPressed: null,
                ),
                new IconButton(
                  icon: Icon(
                    Icons.book,
                  ),
                  onPressed: null,
                ),*/
                new TextButton.icon(
                  icon: Icon(
                    Icons.article_outlined,
                  ),
                  label: Text('Visualizar Alunos'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new Datatable()),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }

  //Esse eh o corpo da tabela
  Widget _getBodyWidget() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 1200,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: aluno.infoaluno.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
        verticalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.yellow,
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        horizontalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.red,
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        enablePullToRefresh: true,
        refreshIndicator: const WaterDropHeader(),
        refreshIndicatorHeight: 60,
        onRefresh: () async {
          //Do sth
          await Future.delayed(const Duration(milliseconds: 500));
          _hdtRefreshController.refreshCompleted();
        },
        htdRefreshController: _hdtRefreshController,
      ),
      height: MediaQuery.of(context).size.height,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'Nome' + (sortType == sortName ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () {
          sortType = sortName;
          isAscending = !isAscending;
          aluno.sortName(isAscending);
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'Estado' +
                (sortType == sortStatus ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () {
          sortType = sortStatus;
          isAscending = !isAscending;
          aluno.sortStatus(isAscending);
          setState(() {});
        },
      ),
      _getTitleItemWidget('Classe', 200),
      _getTitleItemWidget('Bairro', 100),
      _getTitleItemWidget('Contacto', 200),
      _getTitleItemWidget('Contacto_Enc', 200),
      _getTitleItemWidget('Data_Pagamento', 200),
      _getTitleItemWidget('Valor', 200),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text(aluno.infoaluno[index].nome),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                  aluno.infoaluno[index].estado
                      ? Icons.error_outlined
                      : Icons.done_outlined,
                  color: aluno.infoaluno[index].estado
                      ? Colors.red
                      : Colors.green),
              Text(aluno.infoaluno[index].estado ? 'Divida' : 'Pago')
            ],
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(aluno.infoaluno[index].classe),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(aluno.infoaluno[index].bairro),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(aluno.infoaluno[index].telefone),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(aluno.infoaluno[index].telefone_enc),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(aluno.infoaluno[index].data_pagamento),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(aluno.infoaluno[index].valor.toString()),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Aluno aluno = new Aluno();
}

class n {
  List<Info_Aluno> infoalunoL(List<Info_Aluno> infoaluno) {
    return infoaluno;
  }
}
