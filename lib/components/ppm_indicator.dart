import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PpmIndicator extends StatelessWidget {
  final double ppm;

  const PpmIndicator({super.key, required this.ppm});

  String getSituacao(double ppm) {
    if (ppm <= 100) {
      return ' Ótima';
    } else if (ppm <= 300) {
      return ' Moderada';
    } else {
      return ' Ruim';
    }
  }

  Color getSituacaoColor(double ppm, theme) {
    if (ppm <= 100) {
      return theme.primary;
    } else if (ppm <= 300) {
      return theme.tertiary;
    } else {
      return theme.error;
    }
  }

  double getPpmValue(double ppm) {
    if (ppm >= 400) {
      return 400 / 400;
    } else {
      return ppm / 400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: getPpmValue(ppm)),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 8,
                percent: value,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${ppm.toInt()}',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          'ppm',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                progressColor: getSituacaoColor(ppm, theme),
                backgroundColor:
                    ppm == 0 ? theme.primary.withAlpha(125) : theme.secondary,
                circularStrokeCap: CircularStrokeCap.round,
                startAngle: 180.0,
              );
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Situação atual:',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                getSituacao(ppm),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: getSituacaoColor(ppm, theme),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
