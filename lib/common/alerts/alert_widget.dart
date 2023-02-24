import 'package:flutter/material.dart';

class AlertFetch extends StatelessWidget {
  const AlertFetch({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[Text(body)],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: const Text('Confirmar', style: TextStyle(color: Colors.red),),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
