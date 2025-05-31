import 'package:alpha_front/report/report_main.dart';
import 'package:alpha_front/services/api_service.dart';
import 'package:flutter/cupertino.dart';


class Nutrientm extends StatefulWidget {
  final String mealDate;
  const Nutrientm({super.key, required this.mealDate});

  @override
  State<Nutrientm> createState() => _NutrientmState();
}

class _NutrientmState extends State<Nutrientm> {
  Map<String, double> nutrientRatios = {
    'carbohydrate': 25,
    'protein': 25,
    'fat': 50,
  };

  @override
  void initState() {
    super.initState();
    _loadRealEatKcal();
  }

  Future<void> _loadRealEatKcal() async {
    try {
      List<dynamic> rawData = await ApiService.fetchkcalData(widget.mealDate);

      double totalKcal = 0;
      double totalCarb = 0;
      double totalProtein = 0;
      double totalFat = 0;

      for (final meal in rawData) {
        if (meal is! Map<String, dynamic>) continue;

        double kcal = (meal['kcal'] ?? 0).toDouble();
        double carb = (meal['carbohydrate'] ?? 0).toDouble();
        double protein = (meal['protein'] ?? 0).toDouble();
        double fat = (meal['fat'] ?? 0).toDouble();

        totalKcal += kcal;
        totalCarb += carb;
        totalProtein += protein;
        totalFat += fat;
      }

      double carbRatio = totalKcal > 0 ? ((totalCarb * 4) / totalKcal * 100) : 0;
      double proteinRatio = totalKcal > 0 ? ((totalProtein * 4) / totalKcal * 100) : 0;
      double fatRatio = totalKcal > 0 ? ((totalFat * 9) / totalKcal * 100) : 0;

      setState(() {
        nutrientRatios = {
          'carbohydrate': carbRatio,
          'protein': proteinRatio,
          'fat': fatRatio,
        };
      });
    } catch (e) {
      debugPrint('fetchkcalData 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PieChartExample(
      carbRatio: nutrientRatios['carbohydrate']!,
      proteinRatio: nutrientRatios['protein']!,
      fatRatio: nutrientRatios['fat']!,
    );
  }
}
