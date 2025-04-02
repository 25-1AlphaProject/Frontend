import 'package:alpha_front/widgets/baseappbar.dart';
import 'package:flutter/material.dart';

class MealEdit extends StatefulWidget {
  const MealEdit({super.key});

  @override
  State<MealEdit> createState() => _MealEditState();
}

class _MealEditState extends State<MealEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(title: '식단 수정'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _BreakfastEdit())
                    );
                  },
                  child: Text(
                    '아침',
                  ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _BreakfastEdit())
                    );
                  },
                  child: Text(
                    '점심',
                  ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _BreakfastEdit())
                    );
                  },
                  child: Text(
                    '저녁',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _BreakfastEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BreakfastEditState();
}

class _BreakfastEditState extends State<_BreakfastEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('아침 식단'),
    );
  }
}