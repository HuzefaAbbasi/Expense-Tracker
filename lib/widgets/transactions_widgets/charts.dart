import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/firebase_services/firebase_operations.dart';
import 'package:money_tracker/utils/providers.dart';
import 'package:money_tracker/utils/themes.dart';

class MyChart extends ConsumerWidget {
  const MyChart({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(durationProvider);
    final transactionType = ref.watch(incomeOrExpenseProvider);
    return FutureBuilder<LineChartData>(
        future: mainData(duration, transactionType),
        builder: (BuildContext context, AsyncSnapshot<LineChartData> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show a loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final lineChartData = snapshot.data;
            return LineChart(lineChartData!);
          }
        });
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, int i) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);

    final List<String> monthAbbreviations = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    final List<String> weekAbbreviations = [
      'MON',
      'TUE',
      'WED',
      'THU',
      'FRI',
      'SAT',
      'Sun',
    ];

    Widget text;

    // Check if the provided value is within the range of months
    if (i == 12) {
      final int monthIndex = value.toInt() - 1;
      final String monthAbbreviation = monthAbbreviations[monthIndex];
      text = Text(monthAbbreviation, style: style);
    } // For week
    else if (i == 7) {
      final int weekIndex = value.toInt() - 1;
      final String weekAbbreviation = weekAbbreviations[weekIndex];
      text = Text(weekAbbreviation, style: style);
    } // For month
    else if (i == 31) {
      if (value == 1) {
        text = const Text('1', style: style);
      } else if (value == 6) {
        text = const Text('6', style: style);
      } else if (value == 12) {
        text = const Text('12', style: style);
      } else if (value == 18) {
        text = const Text('18', style: style);
      } else if (value == 24) {
        text = const Text('24', style: style);
      } else if (value == 30) {
        text = const Text('30', style: style);
      } else {
        text = const Text('', style: style);
      }
    } // For rest
    else {
      text = Text(value.toInt().toString(), style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Future<LineChartData> mainData(String value, int type) async {
    // use to give max value of x axis according to selected duaration.
    int noOfDays;
    if (value == 'Week') {
      noOfDays = 7;
    } else if (value == 'Month') {
      noOfDays = 31;
    } else if (value == 'Year') {
      noOfDays = 12;
    } else {
      // For now expecting max 12 trasactions per day,
      // as we are not storig time so just handling by no. of transactions
      noOfDays = 10;
    }

    return LineChartData(
      gridData: const FlGridData(
        show: false,
        horizontalInterval: 1,
        verticalInterval: 1,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          drawBelowEverything: false,
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: ((value, meta) =>
                bottomTitleWidgets(value, meta, noOfDays)),
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
          tooltipBorder: const BorderSide(color: MyThemes.greenColor),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              if (flSpot.x == 0 || flSpot.x == 6) {
                return null;
              }
              return LineTooltipItem(
                (flSpot.y.toInt() >= 10.0)
                    ? '${flSpot.y * 10}K +'
                    : '${flSpot.y * 10}K',
                const TextStyle(
                  color: MyThemes.greenColor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              );
            }).toList();
          },
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 1,
      maxX: noOfDays.toDouble(),
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: await MyFirebaseOperations()
              .getFlSpots(duration: value, transactionType: type),
          isCurved: true,
          gradient: const LinearGradient(
              colors: [MyThemes.lightGreenColor, MyThemes.greenColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(colors: [
                MyThemes.lightGreenColor.withOpacity(0.4),
                MyThemes.chartGradient.withOpacity(0)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        ),
      ],
    );
  }
}
