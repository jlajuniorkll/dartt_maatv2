import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatusDashBoard extends StatelessWidget {
  const StatusDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 25),
      ChartData('Steve', 38),
      ChartData('Jack', 34),
      ChartData('Others', 52)
    ];
    return Center(
      child: SfCircularChart(
          // Enables the tooltip for all the series in chart
          tooltipBehavior: TooltipBehavior(enable: true),
          title: ChartTitle(text: 'Reclamações por situação'),
          legend: Legend(isVisible: true),
          series: <CircularSeries>[
            // Render pie chart
            PieSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              explode: true,
              explodeIndex: 3,
            )
          ]),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
