import 'package:alpha_front/Home/home.dart';
import 'package:alpha_front/meal/camera.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/layout.dart';

class MealCardData {
  String name;
  String calories;
  String amount;
  String? imageURL;
  bool isEditing;
  bool realEatBool;

  MealCardData({
    required this.name,
    required this.calories,
    required this.amount,
    this.imageURL,
    this.isEditing = false,
    this.realEatBool = false,
  });
}
class MealEdit extends StatefulWidget {
  final int initialIndex; // 1: 아침, 2: 점심, 3:저녁

  final List<Map<String, dynamic>> recommendBreakfastList;
  final List<Map<String, dynamic>> recommendLunchList;
  final List<Map<String, dynamic>> recommendDinnerList;

  const MealEdit({
    super.key,
    required this.initialIndex,
    required this.recommendBreakfastList,
    required this.recommendLunchList,
    required this.recommendDinnerList,
  });

  @override
  State<MealEdit> createState() => _MealEditState();
}

class _MealEditState extends State<MealEdit> {
  void _goToNext() { // 식단 추가하기 -> 도 카메라? (새로운 사진)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Layout()),
    );
  }

  void _skip() { // 다시 인식하기
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Camera()),
    );
  }

  late int selectedIndex; // 기본

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  Widget _getSelectedWidget() {
    switch (selectedIndex) {
      case 1:
        return _BreakfastEdit(
            recommendBreakfastList: widget.recommendBreakfastList);
      case 2:
        return _LunchEdit();
      case 3:
        return _DinnerEdit();
      default:
        return _BreakfastEdit(
            recommendBreakfastList: widget.recommendBreakfastList);
    }
  }

  void _onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: BaseAppbar(title: '식단 수정'),
      body: Padding(
        padding: const EdgeInsets.all(33.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
              child: Row(
                children: [
                  for (var i = 1; i <= 3; i++)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: i == 1 ? 0 : 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedIndex == i
                                ? const Color(0xff3CB196)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () => _onButtonPressed(i),
                          child: Text(
                            ['아침', '점심', '저녁'][i - 1],
                            style: TextStyle(
                              fontFamily: 'Pretendard-bold',
                              fontSize: 20,
                              color: selectedIndex == i
                                  ? Colors.white
                                  : const Color(0xff3CB196),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
                ],
            ),
            ),
            //   ],
            // ),
            Expanded(
              flex: 6,
              child: _getSelectedWidget(),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        // margin: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffd9d9d9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            minimumSize: const Size(double.infinity, 50),
                            elevation: 3,
                          ),
                          onPressed: _skip,
                          child: Text(
                            '다시 인식',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: const Color(0xff4d4d4d)),
                          ),
                        ),
                      )),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      // margin: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          minimumSize: const Size(double.infinity, 50),
                          elevation: 3,
                        ),
                        onPressed: _goToNext,
                        child: Text('식단 추가',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: const Color(0xff3CB196),
                                )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
      ),
    )
    );
  }
}


class MealEditTab extends StatefulWidget {
  final List<Map<String, dynamic>> initialList;
  final String mealName;

  const MealEditTab({
    super.key,
    required this.initialList,
    required this.mealName,
  });

  @override
  State<MealEditTab> createState() => _MealEditTabState();
}

class _MealEditTabState extends State<MealEditTab> {
  late List<MealCardData> mealCards;
  final List<TextEditingController> nameControllers = [];
  final List<TextEditingController> kcalControllers = [];
  final List<TextEditingController> amountControllers = [];

  @override
  void initState() {
    super.initState();
    mealCards = widget.initialList
        .map((item) => MealCardData(
              name: item['name'] ?? '',
              calories: item['calories']?.toString() ?? '',
              amount: '1',
              imageURL: item['foodImage'],
              isEditing: false,
              realEatBool: false,
            ))
        .toList();
    for (var card in mealCards) {
      nameControllers.add(TextEditingController(text: card.name));
      kcalControllers.add(TextEditingController(text: card.calories));
      amountControllers.add(TextEditingController(text: card.amount));
    }
  }

  @override
  void dispose() {
    for (var c in nameControllers) c.dispose();
    for (var c in kcalControllers) c.dispose();
    for (var c in amountControllers) c.dispose();
    super.dispose();
  }

  void _addMealCard() {
    setState(() {
      mealCards.add(MealCardData(
        name: '',
        calories: '',
        amount: '',
        imageURL: null,
        isEditing: true,
        realEatBool: false,
      ));
      nameControllers.add(TextEditingController());
      kcalControllers.add(TextEditingController());
      amountControllers.add(TextEditingController());
    });
  }

  void _toggleEdit(int idx) {
    setState(() {
      if (mealCards[idx].isEditing) {
        mealCards[idx].name = nameControllers[idx].text;
        mealCards[idx].calories = kcalControllers[idx].text;
        mealCards[idx].amount = amountControllers[idx].text;
      }
      mealCards[idx].isEditing = !mealCards[idx].isEditing;
    });
  }

  void _toggleRealEat(int idx) {
    setState(() {
      mealCards[idx].realEatBool = !mealCards[idx].realEatBool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: mealCards.length,
            itemBuilder: (context, idx) {
              return MealCard(
                imageURL: mealCards[idx].imageURL,
                isEditing: mealCards[idx].isEditing,
                nameController: nameControllers[idx],
                kcalController: kcalControllers[idx],
                amountController: amountControllers[idx],
                onEditToggle: () => _toggleEdit(idx),
                realEatBool: mealCards[idx].realEatBool,
                onCheckPressed: () => _toggleRealEat(idx),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: IconButton(
            icon: const Icon(Icons.add_circle, size: 40, color: Color(0xff3CB196)),
            onPressed: _addMealCard,
            tooltip: '${widget.mealName} 식단 추가',
          ),
        ),
      ],
    );
  }
}


class MealCard extends StatelessWidget {
  final String? imageURL;
  final bool isEditing;
  final TextEditingController nameController;
  final TextEditingController kcalController;
  final TextEditingController amountController;
  final VoidCallback onEditToggle;
  final bool realEatBool;
  final VoidCallback onCheckPressed;

  const MealCard({
    super.key,
    required this.imageURL,
    required this.isEditing,
    required this.nameController,
    required this.kcalController,
    required this.amountController,
    required this.onEditToggle,
    this.realEatBool = false,
    required this.onCheckPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 130,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageURL == null
                  ? Image.asset('../assets/images/character.png',
                      width: 50, height: 50, fit: BoxFit.cover)
                  : Image.network(imageURL!,
                      width: 50, height: 50, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: isEditing
                            ? TextField(
                                controller: nameController,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 8),
                                  border: UnderlineInputBorder(),
                                ),
                              )
                            : Text(
                                nameController.text,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, size: 20),
                            onPressed: onEditToggle,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              color: realEatBool
                                  ? const Color(0xff3CB196)
                                  : Colors.grey,                              
                                  size: 20),
                            onPressed: onCheckPressed,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      isEditing
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  0.3, // 전체의 약 절반
                              child: TextField(
                                controller: kcalController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 4),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            )
                          : Text(
                              "${kcalController.text} kcal",
                              style: const TextStyle(fontSize: 14),
                            ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      isEditing
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 4),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            )
                          : Text(
                              "${amountController.text} 인분",
                              style: const TextStyle(fontSize: 14),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 아침
class _BreakfastEdit extends StatefulWidget {
  final List<Map<String, dynamic>> recommendBreakfastList;

  const _BreakfastEdit({required this.recommendBreakfastList});

  @override
  State<_BreakfastEdit> createState() => _BreakfastEditState();
}

class _BreakfastEditState extends State<_BreakfastEdit> {
  bool isEditing = false;
  bool realEatBool = false;

  TextEditingController nameController =
      TextEditingController(text: recommendBreakfastList[0]["name"]);
  TextEditingController kcalController = TextEditingController(
      text: recommendBreakfastList[0]["calories"].toString());
  TextEditingController amountController = TextEditingController(text: "1");

  void _toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MealCard(
        imageURL: recommendBreakfastList[0]["foodImage"],
        isEditing: isEditing,
        amountController: amountController,
        nameController: nameController,
        kcalController: kcalController,
        onEditToggle: _toggleEditMode,
        realEatBool: realEatBool,
        onCheckPressed: () {
          setState(() {
            realEatBool = !realEatBool;
          });
    },
      ),
    );
  }
}

class _LunchEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LunchEditState();
}

class _LunchEditState extends State<_LunchEdit> {
  bool isEditing = false;
  bool realEatBool = false;

  TextEditingController nameController =
      TextEditingController(text: "오이");
  TextEditingController kcalController = TextEditingController(
      text: "100");
  TextEditingController amountController = TextEditingController(text: "1");

  void _toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: MealCard(
            imageURL: null,
            isEditing: isEditing,
            amountController: amountController,
            nameController: nameController,
            kcalController: kcalController,
            onEditToggle: _toggleEditMode,
            realEatBool: realEatBool,
            onCheckPressed: () {
              setState(() {
                realEatBool = !realEatBool;
              });
        },
          ),
        ),
        
      ],
    );
  }
}

class _DinnerEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DinnerEditState();
}

class _DinnerEditState extends State<_DinnerEdit> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Text('저녁 식단'),
    );
  }
}