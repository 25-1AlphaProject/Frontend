import 'package:alpha_front/survey/diet_info.dart';
import 'package:alpha_front/survey/pre_survey4.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class PreSurvey3 extends StatefulWidget {
  const PreSurvey3({super.key});

  @override
  State<PreSurvey3> createState() => _PreSurvey3State();
}

class _PreSurvey3State extends State<PreSurvey3> {
  TextEditingController searchController1 = TextEditingController();
  TextEditingController searchController2 = TextEditingController();

  List<String> selectedLikeFood = [];
  List<String> selectedHateFood = [];

  void _addLikeFood(String input) {
    if (input.isEmpty) return;

    List<String> terms = input
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    setState(() {
      for (var likeFoodTerm in terms) {
        if (!selectedLikeFood.contains(likeFoodTerm)) {
          selectedLikeFood.add(likeFoodTerm);
        }
      }
    });

    searchController1.clear();
  }

  void _removeLikeFood(String term) {
    setState(() {
      selectedLikeFood.remove(term);
    });
  }

  void _addHateFood(String input) {
    if (input.isEmpty) return;

    List<String> terms = input
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    setState(() {
      for (var hateFoodTerm in terms) {
        if (!selectedHateFood.contains(hateFoodTerm)) {
          selectedHateFood.add(hateFoodTerm);
        }
      }
    });

    searchController2.clear();
  }

  void _removeHateFood(String term) {
    setState(() {
      selectedHateFood.remove(term);
    });
  }

  void _goToNext() {
    DietInfo.preferredMenus = selectedLikeFood;
    DietInfo.avoidIngredients = selectedHateFood;

    print('preferred 저장됨: ${DietInfo.preferredMenus}');
    print('Weiavoidght 저장됨: ${DietInfo.avoidIngredients}');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreSurvey4()),
    );
  }

  void _skip() {
    DietInfo.preferredMenus = [];
    DietInfo.avoidIngredients = [];
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreSurvey4()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: BaseAppbar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(33, 78, 33, 31),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text.rich(
                  TextSpan(
                    text: '선호 ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: 'Pretendard-bold'),
                    children: [
                      TextSpan(
                        text: '혹은 ',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: '기피 식품',
                      ),
                      TextSpan(
                        text: '이 \n있으신가요?',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                ),
              ),
            ),

            // 선호 식품 검색 TextField
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: searchController1,
              decoration: InputDecoration(
                hintText: "선호 식품 검색",
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),
                border: UnderlineInputBorder(),
              ),
              onSubmitted: _addLikeFood,
            ),
            SizedBox(height: 20),

            // 선호 식품 목록 표시
            Wrap(
              spacing: 8.0,
              children: selectedLikeFood
                  .map(
                    (term) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                        backgroundColor: Color(0xff3CB196),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(term),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _removeLikeFood(term),
                            child: Icon(Icons.close, color: Colors.white, size: 16),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 20),

            // 기피 식품 검색 TextField
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: searchController2,
              decoration: InputDecoration(
                hintText: "기피 식품 검색",
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),
                border: UnderlineInputBorder(),
              ),
              onSubmitted: _addHateFood,
            ),
            SizedBox(height: 20),

            // 기피 식품 목록 표시
            Wrap(
              spacing: 8.0,
              children: selectedHateFood
                  .map(
                    (term) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                        backgroundColor: Color(0xff3CB196),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(term),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _removeHateFood(term),
                            child: Icon(Icons.close, color: Colors.white, size: 16),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),

            SizedBox(height: 100),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffd9d9d9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        minimumSize: const Size(double.infinity, 50),
                        elevation: 3,
                      ),
                      onPressed: _skip,
                      child: Text(
                        '생략할게요',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Color(0xff4d4d4d)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff3CB196),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        minimumSize: const Size(double.infinity, 50),
                        elevation: 3,
                      ),
                      onPressed: _goToNext,
                      child: Text(
                        '다음',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
