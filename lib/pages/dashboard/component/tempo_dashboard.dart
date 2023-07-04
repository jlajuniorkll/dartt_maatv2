import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TempoDashboard extends StatelessWidget {
  const TempoDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Estimado', 25, const Color.fromARGB(255, 198, 0, 0)),
      ChartData('Médio', 34, const Color.fromARGB(255, 49, 210, 0)),
    ];
    return Center(
        child: SfCircularChart(
            title: ChartTitle(text: 'Tempo Médio/Estimado'),
            legend: const Legend(isVisible: true),
            series: <CircularSeries>[
          // Renders doughnut chart
          DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              startAngle: 270,
              // Ending angle of doughnut
              endAngle: 90)
        ]));
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
