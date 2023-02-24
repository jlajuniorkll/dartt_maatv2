
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TrendDashboard extends StatelessWidget {
  const TrendDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SfCartesianChart(

          primaryXAxis: CategoryAxis(),
          // Chart title
          title: ChartTitle(text: 'Reclamações Mensais'),
          // Enable legend
          // legend: Legend(isVisible: true),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),

          series: <LineSeries<SalesData, String>>[
            LineSeries<SalesData, String>(
              dataSource:  <SalesData>[
                SalesData('Jan', 35),
                SalesData('Fev', 28),
                SalesData('Mar', 34),
                SalesData('Abr', 32),
                SalesData('Mai', 25),
                SalesData('Jun', 20),
                SalesData('Jul', 52),
                SalesData('Ago', 58),
                SalesData('Set', 150),
                SalesData('Out', 51),
                SalesData('Nov', 80),
                SalesData('Dez', 210),

              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
              // Enable data label
              dataLabelSettings: const DataLabelSettings(isVisible: true)
            )
          ]
        )
      );
  }
}
class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}