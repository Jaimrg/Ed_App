import 'package:flutter/material.dart';

import '../model/Estudante.dart';

class VerMaisDialog extends StatefulWidget {
  final Estudante? estudante;
  final Function(String name, double amount, bool isExpense) onClickedDone;

  const VerMaisDialog({
    Key? key,
    this.estudante,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _VerMaisDialogState createState() => _VerMaisDialogState();
}

class _VerMaisDialogState extends State<VerMaisDialog> {
  final formKey = GlobalKey<FormState>();
  String classe = '';
  String contacto = '';
  String contacto_2 = '';
  @override
  void initState() {
    super.initState();

    if (widget.estudante != null) {
      final estudante = widget.estudante!;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.estudante != null;
    final title = 'Mais Dados Do Aluno';

    return AlertDialog(
        title: Text(title),
        content: const Text('Classe: Jaime'
                '\n' +
            'Contacto: 874735265' +
            '\n' +
            'Contacto_Alt: 843736253'),
        actions: <Widget>[
          //buildCancelButton(context),
          //buildOkButton(context),
          TextButton(
            child: Text('Fechar'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ]);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void getDados(String classe, String cont, String cont2) {}

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Fechar'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildOkButton(BuildContext context) {
    final text = 'Ok';

    return TextButton(
      child: Text(text),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
  }
}
