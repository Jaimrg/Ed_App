import 'package:flutter/material.dart';
import 'data_table.dart';
import 'model/Info_Aluno.dart';
import 'model/Aluno.dart';
import 'widget/button_widget.dart';

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
    '1ª a 7ª Classes',
    '8ª a 10ª Classes',
    '11ª e 12ª Classes',
    'Preparação Para Exames',
    'Ensino Médio',
    'Ensino Superior'
  ];

  TextEditingController nome = new TextEditingController();
  String name = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nome_f = '';
  String bairro = '';
  String contacto = '';
  String contacto_enc = '';
  String classe = '';
  //late String value;

  final topBar = new AppBar(
    backgroundColor: Colors.white,
    // centerTitle: true,
    elevation: 0.0,
    leading: new Icon(Icons.arrow_back_ios, color: Colors.black),
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

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nome'),
      maxLength: 20,
      controller: nome,
      validator: (value) {
        if (value!.length < 4) {
          return 'Enter at least 4 characters';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() => nome_f = value.toString()),
    );
  }

  Widget _buildBairro() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Bairro'),
      maxLength: 20,
      validator: (value) {
        if (value!.length < 4) {
          return 'Enter at least 4 characters';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() => bairro = value.toString()),
    );
  }

  Widget _buildTelefone() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Contacto'),
      maxLength: 10,
      validator: (value) {
        if (value!.length < 4) {
          return 'Enter at least 4 characters';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() => contacto = value.toString()),
    );
  }

  Widget _buildTelefone_Enc() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Contacto Do Encarregado'),
      maxLength: 10,
      validator: (value) {
        if (value!.length < 4) {
          return 'Enter at least 4 characters';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() => contacto_enc = value.toString()),
    );
  }

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
          text: 'Submit',
          onClicked: () {
            final isValid = _formKey.currentState!.validate();
            // FocusScope.of(context).unfocus();

            if (isValid) {
              _formKey.currentState!.save();

              final message =
                  'Nome: $nome_f\nBairro: $bairro\nContacto: $contacto';
              final snackBar = SnackBar(
                content: Text(
                  message,
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.green,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              Aluno al = new Aluno();
              al.initData(0, nome_f, bairro, contacto, contacto_enc);
            }
          },
        ),
      );

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
                          buildSubmit(),
                          /*Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            padding: EdgeInsets.only(right: 16.0, left: 16.0),
                            
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              onPressed: () {
                                List<Info_Aluno> infoaluno = [];

                                /*void initData(int size) {
                                  for (int i = 0; i < size; i++) {
                                    infoaluno.add(Info_Aluno(
                                        "Jaime",
                                        i % 2 == 0,
                                        "10",
                                        "Ndlavela",
                                        "8483883828",
                                        "8737363535",
                                        "10/09/2021",
                                        1500));
                                  }
                                }*/

                                AlertDialog(
                                  // Retrieve the text the user has entered by using the
                                  // TextEditingController.
                                  content: Text(nome.text),
                                );
                              },
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
                          )*/
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
