import 'package:flutter/material.dart';

class TotalDashBoard extends StatelessWidget {
  const TotalDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Expanded(child: Center(child: Text('Total de Reclamações: 99999', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),))),
          Expanded(child: Center(child: Text('Total em Abertas: 99999', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),))),
        ],
      ),
    );
  }
}