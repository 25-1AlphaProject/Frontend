import 'package:alpha_front/Home/home.dart';
import 'package:alpha_front/Management/nutrientM.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PieChartExample extends StatelessWidget {
  final double carbRatio;
  final double proteinRatio;
  final double fatRatio;

  const PieChartExample({
    super.key,
    required this.carbRatio,
    required this.proteinRatio,
    required this.fatRatio,
  });

  @override
  Widget build(BuildContext context) {
    final List<_NutrientSection> data = [
      _NutrientSection('탄수화물', carbRatio, const Color(0xffFFCDCC)),
      _NutrientSection('단백질', proteinRatio, const Color(0xff3CB196)),
      _NutrientSection('지방', fatRatio, const Color(0xffFCD297)),
    ];

    final List<PieChartSectionData> sections = List.generate(data.length, (i) {
      return PieChartSectionData(
        value: data[i].percent,
        color: data[i].color,
        title: '${data[i].percent.toStringAsFixed(1)}%',
        titleStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        radius: 60,
        titlePositionPercentageOffset: 0.5,
      );
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 250,
              width: 250,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 65,
                  sectionsSpace: 2,
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            SizedBox(
              width: 90,
              height: 90,
              child: Image.asset(
                '../assets/images/running_character.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _LegendItem(color: Color(0xffF8D6D2), label: '탄수화물'),
            _LegendItem(color: Color(0xff6DB7A8), label: '단백질'),
            _LegendItem(color: Color(0xffF8E1B2), label: '지방'),
          ],
        ),
      ],
    );
  }
}


// 데이터 구조
class _NutrientSection {
  final String label;
  final double percent;
  final Color color;
  const _NutrientSection(this.label, this.percent, this.color);
}

// 범례 위젯
class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'yg-jalnan',
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class ReportMain extends StatefulWidget {
  const ReportMain({super.key});

  @override
  State<ReportMain> createState() => _ReportMainState();
}

class _ReportMainState extends State<ReportMain> {
  double breakfastKcal = getTotalCalories(realEatBreakfastList) ?? 0.0;
  double lunchKcal = getTotalCalories(realEatLunchList) ?? 0.0;
  double dinnerKcal = getTotalCalories(realEatDinnerList) ?? 0.0;

  static double? getTotalCalories(List<dynamic> mealList) {
    if (mealList == null) return 0.0;
    double total = 0.0;
    for (var item in mealList) {
      if (item != null && item['calories'] != null) {
        total += item['calories'] as double;
      }
    }
    return total;
  }

    void updateKcal(String mealType, int kcal) {
    setState(() {
      if (mealType == "아침") {
        breakfastKcal = kcal.toDouble();
      } else if (mealType == "점심") {
        lunchKcal = kcal.toDouble();
      } else if (mealType == "저녁") {
        dinnerKcal = kcal.toDouble();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

      List<double> yValues = [breakfastKcal, lunchKcal, dinnerKcal];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCard(
              title: '오늘의 칼로리',
              child: BarChartExample(yValues: yValues),
              gap: 60,
            ),
            _buildCard(
              title: '오늘의 영양소 섭취',
              child: Nutrientm(mealDate: DateFormat('yyyy-MM-dd').format(DateTime.now())),              
              gap: 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child, required double gap}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      margin: const EdgeInsets.all(33),
      padding: const EdgeInsets.only(left: 10, right: 10, top:15, bottom: 15),
      decoration: BoxDecoration(
        color: const Color(0xff3CB196).withAlpha(20),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color(0xff5DB996),
                  fontSize: 20,
                ),
          ),
          SizedBox(height: gap),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class BarChartExample extends StatelessWidget {
  final List<double> yValues;
  const BarChartExample({super.key, required this.yValues});

  @override
  Widget build(BuildContext context) {
    const double chartHeight = 100;
    const double unitHeight = 1;
    const double imageSize = 60;
    const double barWidth = 60;
    const double barSpacing = 90;

    // List<Widget> barShadows = List.generate(yValues.length, (index) {
    //   double barHeight = yValues[index] * unitHeight;
    //   double top = chartHeight - barHeight + 2;
    //   double left = index * barSpacing + 40;

    //   return Positioned(
    //     top: top,
    //     left: left,
    //     child: Container(
    //       width: barWidth,
    //       height: barHeight,
    //       decoration: BoxDecoration(
    //         // boxShadow: [
    //         //   BoxShadow(
    //         //     color: Colors.black.withAlpha(25), // 10% 투명도
    //         //     offset: const Offset(2, 2),
    //         //     blurRadius: 4,
    //         //   ),
    //         // ],
    //       ),
    //     ),
    //   );
    // });

    

    // List<Widget> imageWidgets = List.generate(yValues.length, (index) {
    //   double y = yValues[index];
    //   double barHeight = y * unitHeight;
    //   double top = chartHeight - barHeight - imageSize;
    //   double left = index * barSpacing + (barWidth) / 3;


    //   return Positioned(
    //     top: top,
    //     left: left,
    //     child: Image.asset(
    //       '../assets/images/character.png',
    //       width: imageSize,
    //       height: imageSize,
    //     ),
    //   );
    // });

    return SizedBox(
      height: chartHeight,
      child: Stack(
        children: [
          BarChart(
            BarChartData(
              barGroups: List.generate(yValues.length, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      fromY: 0,
                      toY: yValues[index],
                      gradient: const LinearGradient(
                        colors: [Color(0xff5DB996), Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      width: barWidth,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                      ),
                    )
                  ],
                );
              }),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 70,
                    getTitlesWidget: (value, meta) {
                      const labels = ['아침', '점심', '저녁'];
                      if (value.toInt() < 0 || value.toInt() >= labels.length) {
                        return const SizedBox();
                      }
                        final index = value.toInt();
                        final yValue = yValues[index];

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${yValue.toInt()}',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text( 
                            labels[index],
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'yg-jalnan',
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
            ),
          ),
          // ...imageWidgets,
        ],
      ),
    );
    

    
  }
}
