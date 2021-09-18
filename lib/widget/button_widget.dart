import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          textStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'Raleway',
            fontSize: 16.0,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
        /* shape: StadiumBorder(),
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textColor: Colors.white,*/
        onPressed: onClicked,
      );
}
/*Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[          
          ElevatedButton(
            style: style,
            onPressed: onClicked,
            child: const Text('Enabled'),
          ),
        ],
      ),
    );
  }*/
