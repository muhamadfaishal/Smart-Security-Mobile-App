import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smartsecurity/pages/infopir.dart';

void main() {
  runApp(MaterialApp(
    home: GrafikSuhuPage(),
  ));
}

class GrafikSuhuPage extends StatelessWidget {
  //data dummy yang akan ditampilkan
  List<BarChartGroupData> barChartGroupData = [
    BarChartGroupData(x: 1, barRods: [
      BarChartRodData(y: 5, colors: [Color(0xFF12283D)]),
    ]),
    BarChartGroupData(x: 2, barRods: [
      BarChartRodData(y: 10, colors: [Color(0xFF12283D)]),
    ]),
    BarChartGroupData(x: 3, barRods: [
      BarChartRodData(y: 13, colors: [Color(0xFF12283D)]),
    ]),
    BarChartGroupData(x: 4, barRods: [
      BarChartRodData(y: 7, colors: [Color(0xFF12283D)]),
    ]),
    BarChartGroupData(x: 5, barRods: [
      BarChartRodData(y: 18, colors: [Color(0xFF12283D)]),
    ]),
    BarChartGroupData(x: 6, barRods: [
      BarChartRodData(y: 11, colors: [Color(0xFF12283D)]),
    ]),
    BarChartGroupData(x: 7, barRods: [
      BarChartRodData(y: 14, colors: [Color(0xFF12283D)]),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoDHT11Page()),
          );
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: BarChart(
                    BarChartData(
                      titlesData: FlTitlesData(
                        topTitles: SideTitles(showTitles: false),
                        rightTitles: SideTitles(showTitles: false),
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 1:
                                return 'Mon';
                              case 2:
                                return 'Tues';
                              case 3:
                                return 'Wed';
                              case 4:
                                return 'Thu';
                              case 5:
                                return 'Fri';
                              case 6:
                                return 'Sat';
                              case 7:
                                return 'Sun';
                            }
                            return '';
                          },
                        ),
                        leftTitles: SideTitles(
                          interval: 5,
                          showTitles: true,
                          getTitles: (value) {
                            if (value.toInt() == 0)
                              return '';
                            else
                              return value.toInt().toString();
                          },
                        ),
                      ),
                      maxY: 20,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: barChartGroupData,
                    ),
                  ),
                ),
                SizedBox(
                    height:
                        10), // Menggunakan SizedBox untuk memberi ruang di bawah grafik
              ],
            ),
          ),
        ),
      ),
    );
  }
}
