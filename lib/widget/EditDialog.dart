import 'package:flutter/material.dart';

//
import 'package:ed_app/model/Estudante.dart';

class EditDialog extends StatefulWidget {
  final Estudante? estudante;
  final BuildContext contexto;
  final Function(String nome, String bairro, String telefone,
      String telefone_enc, BuildContext contexto) onClickedDone;

  const EditDialog({
    Key? key,
    this.estudante,
    required this.contexto,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  List _classes = [
    '1ª a 7ª Classes',
    '8ª a 10ª Classes',
    '11ª e 12ª Classes',
    'Preparação Para Exames',
    'Ensino Médio',
    'Ensino Superior'
  ];
  final sugars = [
    '1ª a 7ª Classes',
    '8ª a 10ª Classes',
    '11ª e 12ª Classes',
    'Preparação Para Exames',
    'Ensino Médio',
    'Ensino Superior'
  ];
  String? _currentSugars = '1ª a 7ª Classes';
  TextEditingController nomeC = new TextEditingController();
  TextEditingController bairroC = new TextEditingController();
  TextEditingController telefone = new TextEditingController();
  TextEditingController telefone_enc = new TextEditingController();
  String name = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nome_f = '';
  String bairro = '';
  String contacto = '';
  String contacto_enc = '';
  String classe = '';

  @override
  void initState() {
    super.initState();

    if (widget.estudante != null) {
      final transaction = widget.estudante!;

      nomeC.text = transaction.nome;
      bairroC.text = transaction.bairro;
      telefone.text = transaction.telefone;
      telefone_enc.text = transaction.telefone;
    }
  }

  @override
  void dispose() {
    nomeC.dispose();
    bairroC.dispose();
    telefone.dispose();
    telefone_enc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmacao'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              _buildName(),
              SizedBox(height: 8),
              _buildBairro(),
              SizedBox(height: 8),
              _buildTelefone(),
              SizedBox(height: 8),
              _buildTelefone_Enc(),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _currentSugars,
                // decoration: const textInputDecoration,
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text(sugar),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _currentSugars = val),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancelar',
            style: TextStyle(color: Colors.black),
          ),
        ),
        buildAddButton(context),
      ],
    );
  }

  Widget buildAddButton(BuildContext context) {
    return TextButton(
      child: Text('Atualizar'),
      onPressed: () async {
        final isValid = _formKey.currentState!.validate();

        if (isValid) {
          final nome = nomeC.text;
          final bairro = bairroC.text;
          final telefoneb = telefone.text;
          final telefone_encb = telefone_enc.text;

          widget.onClickedDone(nome, bairro, telefoneb, telefone_encb, context);

          Navigator.of(context).pop();
        }
      },
    );
  }

  //

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nome'),
      maxLength: 20,
      controller: nomeC,
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

  Widget _buildBairro() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Bairro'),
      maxLength: 20,
      controller: bairroC,
      validator: (value) {
        if (value!.length < 2) {
          return 'Digite Pelomenos 2 Caracteres';
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
      controller: telefone,
      validator: (value) {
        if (value!.length < 9) {
          return 'Digite Pelo menos 9 Digitos';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      onSaved: (value) => setState(() => contacto = value.toString()),
    );
  }

  Widget _buildTelefone_Enc() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Contacto Do Encarregado'),
      maxLength: 10,
      controller: telefone_enc,
      validator: (value) {
        if (value!.length < 9) {
          return 'Digite Pelo menos 9 Digitos';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      onSaved: (value) => setState(() => contacto_enc = value.toString()),
    );
  }

  void clean() {
    nomeC.clear();
    bairroC.clear();
    telefone.clear();
    telefone_enc.clear();
  }
}
