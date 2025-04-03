import 'package:alpha_front/Home/home.dart';
import 'package:alpha_front/widgets/baseappbar.dart';
import 'package:flutter/material.dart';

class MealEdit extends StatefulWidget {
  const MealEdit({super.key});

  @override
  State<MealEdit> createState() => _MealEditState();
}

class _MealEditState extends State<MealEdit> {

  int selectedIndex = 1; // 기본


  Widget _getSelectedWidget() {
    switch (selectedIndex) {
      case 1:
        return _BreakfastEdit();
      case 2:
        return _LunchEdit();
      case 3:
        return _DinnerEdit();
      default:
        return _BreakfastEdit();
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
      appBar: BaseAppbar(title: '식단 수정'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedIndex == 1 ? Color(0xFF118B50) : Colors.white,
                    ),
                    onPressed: () => _onButtonPressed(1),
                  child: Text(
                      '아침',
                      style: TextStyle(
                        color: selectedIndex == 1 ? Colors.white : Color(0xff118B50),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedIndex == 2 ? Color(0xFF118B50) : Colors.white,
                    ),
                    onPressed: () => _onButtonPressed(2), 
                  child: Text(
                      '점심',
                      style: TextStyle(
                        color: selectedIndex == 2 ? Colors.white : Color(0xff118B50),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedIndex == 3 ? Color(0xFF118B50) : Colors.white,
                    ),
                    onPressed: () => _onButtonPressed(3),
              
                    child: Text(
                      '저녁',
                      style: TextStyle(
                        color: selectedIndex == 3 ? Colors.white : Color(0xff118B50),
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
              flex: 1,
              child: Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff118B50),
                      shape : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide(color: Color(0xff118B50), width: 1),
                      elevation: 3,
                      
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen())
                      );
                    }, 
                      child: Text(
                      '작성 완료',
                        style: TextStyle(
                        fontFamily: 'PretendartVariable',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                  
                      ),
                    ),
                    ),
                ),
              ),
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

    bool isEditing = false; // 편집 모드
  TextEditingController _controller = TextEditingController(text: "1"); // 초기값 1

  void _toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _saveEdit() {
    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Text('아침 식단'),
      body : Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: MediaQuery.of(context).size.height * 0.8,
            height: MediaQuery.of(context).size.height * 0.15,
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                // 우측 상단 Edit 아이콘
                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                    icon: Icon(Icons.edit, color: Colors.black),
                    onPressed: _toggleEditMode,
                  ),
                ),

                // 가운데 숫자 또는 TextField
                Center(
                  child: isEditing
                      ? TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 24,
                          fontFamily: 'PretendardVariable',
                          fontWeight: FontWeight.bold),
                          onSubmitted: (_) => _saveEdit(), // 엔터 입력 시 저장
                        )
                      : Text(
                          textAlign: TextAlign.start,
                          _controller.text,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'PretendardVariable'),
                        ),
                ),
              ],
            ),
          ),
        ),
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
    return Scaffold(
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
    return Scaffold(
      body: Text('저녁 식단'),
    );
  }
}