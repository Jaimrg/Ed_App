import 'package:flutter/material.dart';
import 'data_table.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  //Variaveis
  late String _classe;
  List _classes = [
    '1ª a 7ª',
    '8ª a 10ª',
    '11ª e 12ª',
    'Preparação',
    'Médio',
    'Superior'
  ];
  //late String value;

  final topBar = new AppBar(
    backgroundColor: Colors.white,
    // centerTitle: true,
    elevation: 0.0,
    leading: new Icon(Icons.arrow_back_ios, color: Colors.black),
    /*title: new Padding(
      //height: 35.0,
      padding: const EdgeInsets.only(left: 175.0),
      child: new Text("CADASTRAR"),
      
    ),*/
    actions: <Widget>[
      Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 19.0),
          child: new Text(
            "CADASTRAR",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.normal,
                fontFamily: 'AkayaTelivigala'),
          ))
    ],
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nome'),
      maxLength: 20,
    );
  }

  Widget _buildBairro() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Bairro'),
      maxLength: 20,
    );
  }

  Widget _buildTelefone() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Contacto'),
      maxLength: 10,
    );
  }

  Widget _buildTelefone_Enc() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Contacto Do Encarregado'),
      maxLength: 10,
    );
  }

  Widget? _buildClasse() {}

  var selectedCurrency, selectedType;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  List<String> _accountType = <String>[
    'Savings',
    'Deposit',
    'Checking',
    'Brokerage'
  ];
  final sugars = [
    '1ª a 7ª',
    '8ª a 10ª',
    '11ª e 12ª',
    'Preparação',
    'Médio',
    'Superior'
  ];
  String? _currentSugars = '1ª a 7ª';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: topBar,
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.all(24),
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildName(),
                          _buildBairro(),
                          _buildTelefone(),
                          _buildTelefone_Enc(),
                          SizedBox(height: 30),
                          /*Container(
                            child: DropdownButton(
                          hint: Text('Classe'),
                          value: _classe,
                          items: _classes.map((value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                               _classe = value;
                            });
                          },
                        ))*/

                          DropdownButtonFormField<String>(
                            value: _currentSugars,
                            // decoration: const textInputDecoration,
                            items: sugars.map((sugar) {
                              return DropdownMenuItem(
                                value: sugar,
                                child: Text(sugar),
                              );
                            }).toList(),
                            onChanged: (val) =>
                                setState(() => _currentSugars = val),
                          ),
                          SizedBox(height: 30),
                          Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            padding: EdgeInsets.only(right: 16.0, left: 16.0),
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              onPressed: () {},
                              color: Colors.blue[300],
                              child: Text(
                                "Cadastrar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Raleway',
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          )
                        ])))),
        bottomNavigationBar: new Container(
          color: Colors.white,
          height: 50.0,
          alignment: Alignment.center,
          child: new BottomAppBar(
            child: new Row(
              // alignment: MainAxisAlignment.spaceAround,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new IconButton(
                  icon: Icon(Icons.group_add_rounded),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new FormScreen()),
                    );
                  },
                ),
                new IconButton(
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
                ),
                new IconButton(
                  icon: Icon(
                    Icons.account_circle_rounded,
                  ),
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
}
