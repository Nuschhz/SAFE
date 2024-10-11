import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PpmChart extends StatelessWidget {
  final double ppmValue;

  const PpmChart({super.key, required this.ppmValue});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        final style = TextStyle(
                          color: theme.onSurface,
                          fontSize: 12,
                        );
                        switch (value.toInt()) {
                          case 0:
                            return Text('00h', style: style);
                          case 3:
                            return Text('03h', style: style);
                          case 6:
                            return Text('06h', style: style);
                          case 9:
                            return Text('09h', style: style);
                          case 12:
                            return Text('12h', style: style);
                          case 15:
                            return Text('15h', style: style);
                          case 18:
                            return Text('18h', style: style);
                          case 21:
                            return Text('21h', style: style);
                          default:
                            return const Text('');
                        }
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                barGroups: _buildBarData(theme),
                gridData: const FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Ajuste das cores para os novos limiares
  Color getSituacaoColor(double ppm, theme) {
    if (ppm <= 100) {
      return theme.primary; // Verde ou cor primária
    } else if (ppm <= 300) {
      return theme.tertiary; // Amarelo/Laranja
    } else {
      return theme.error; // Vermelho
    }
  }

  List<BarChartGroupData> _buildBarData(theme) {
    return [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(toY: 20, color: getSituacaoColor(20, theme), width: 12),
      ]),
      BarChartGroupData(x: 3, barRods: [
        BarChartRodData(toY: 50, color: getSituacaoColor(50, theme), width: 12),
      ]),
      BarChartGroupData(x: 6, barRods: [
        BarChartRodData(toY: 8, color: getSituacaoColor(8, theme), width: 12),
      ]),
      BarChartGroupData(x: 9, barRods: [
        BarChartRodData(
            toY: 100, color: getSituacaoColor(10, theme), width: 12),
      ]),
      BarChartGroupData(x: 12, barRods: [
        BarChartRodData(
            toY: 480, color: getSituacaoColor(480, theme), width: 12),
      ]),
      BarChartGroupData(x: 15, barRods: [
        BarChartRodData(
            toY: 120, color: getSituacaoColor(120, theme), width: 12),
      ]),
      BarChartGroupData(x: 18, barRods: [
        BarChartRodData(
            toY: 300, color: getSituacaoColor(300, theme), width: 12),
      ]),
      BarChartGroupData(x: 21, barRods: [
        BarChartRodData(
            toY: ppmValue, color: getSituacaoColor(ppmValue, theme), width: 12),
      ]),
    ];
  }
}
