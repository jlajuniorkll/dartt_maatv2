

import 'package:flutter/material.dart';

class TableUserDashBoard extends StatelessWidget {
  const TableUserDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Usuario',
              style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Prazo',
              style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Vencendo',
              style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Atrasado',
              style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah daSilva Gonçalves de Almeida')),
            DataCell(Text('0')),
            DataCell(Text('1')),
            DataCell(Text('12')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine da conceição')),
            DataCell(Text('123')),
            DataCell(Text('58')),
            DataCell(Text('1')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William Roberto de Souza da Silva Xavier')),
            DataCell(Text('5')),
            DataCell(Text('4')),
            DataCell(Text('45')),
          ],
        ),

                DataRow(
          cells: <DataCell>[
            DataCell(Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
            DataCell(Text('5', style: TextStyle(fontWeight: FontWeight.bold))),
            DataCell(Text('4', style: TextStyle(fontWeight: FontWeight.bold))),
            DataCell(Text('45', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      ],
    );
  }
}