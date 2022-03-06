import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class nomefield extends StatefulWidget {
  const nomefield({Key? key}) : super(key: key);

  @override
  _nomefieldState createState() => _nomefieldState();
}

class _nomefieldState extends State<nomefield> {
  TextEditingController nome = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nome_f = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nome'),
      maxLength: 20,
      controller: nome,
      validator: (value) {
        if (value!.length < 2) {
          return 'Digite Pelomenos 2 Caracteres';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() => nome_f = value.toString()),
    );
  }
}
