import 'package:alpha_front/Home/home.dart';
import 'package:alpha_front/meal/camera.dart';
import 'package:alpha_front/services/api_service.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/layout.dart';

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
  void _goToNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Layout()),
    );
  }

  void _skip() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Camera()),
    );
  }

  late int selectedIndex;

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
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedIndex == 1
                              ? const Color(0xff3CB196)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () => _onButtonPressed(1),
                        child: Text(
                          '아침',
                          style: TextStyle(
                            fontFamily: 'Pretendard-bold',
                            fontSize: 20,
                            color: selectedIndex == 1
                                ? Colors.white
                                : const Color(0xff3CB196),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedIndex == 2
                              ? const Color(0xff3CB196)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () => _onButtonPressed(2),
                        child: Text(
                          '점심',
                          style: TextStyle(
                            fontFamily: 'Pretendard-bold',
                            fontSize: 20,
                            color: selectedIndex == 2
                                ? Colors.white
                                : const Color(0xff3CB196),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedIndex == 3
                              ? const Color(0xff3CB196)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () => _onButtonPressed(3),
                        child: Text(
                          '저녁',
                          style: TextStyle(
                            fontFamily: 'Pretendard-bold',
                            fontSize: 20,
                            color: selectedIndex == 3
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
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
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
                        child: Text(
                          '식단 추가',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: const Color(0xff3CB196)),
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

  const MealCard({
    super.key,
    required this.imageURL,
    required this.isEditing,
    required this.nameController,
    required this.kcalController,
    required this.amountController,
    required this.onEditToggle,
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
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: onEditToggle,
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

class _BreakfastEdit extends StatefulWidget {
  final List<Map<String, dynamic>> recommendBreakfastList;

  const _BreakfastEdit({required this.recommendBreakfastList});

  @override
  State<_BreakfastEdit> createState() => _BreakfastEditState();
}

class _BreakfastEditState extends State<_BreakfastEdit> {
  bool isEditing = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController kcalController = TextEditingController();
  TextEditingController amountController = TextEditingController(text: "1");

  String? imageUrl;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.recommendBreakfastList[0]["name"];
    kcalController.text =
        widget.recommendBreakfastList[0]["calories"].toString();

    _loadImage(widget.recommendBreakfastList[0]["foodImage"]);
  }

  Future<void> _loadImage(String imagePath) async {
    try {
      final result = await ApiService.getImage(imagePath);
      setState(() {
        imageUrl = result;
      });
    } catch (e) {
      debugPrint('이미지 불러오기 실패: $e');
    }
  }

  void _toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MealCard(
        imageURL: imageUrl,
        isEditing: isEditing,
        amountController: amountController,
        nameController: nameController,
        kcalController: kcalController,
        onEditToggle: _toggleEditMode,
      ),
    );
  }
}

class _LunchEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LunchEditState();
}

class _LunchEditState extends State<_LunchEdit> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Text('점심 식단'),
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
