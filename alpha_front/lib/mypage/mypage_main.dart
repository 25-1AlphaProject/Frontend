import 'dart:io';

import 'package:alpha_front/Login/login.dart';
import 'package:alpha_front/mypage/mypage_myinfo.dart';
import 'package:alpha_front/mypage/mypage_mylike.dart';
import 'package:alpha_front/mypage/mypage_myscrap.dart';
import 'package:alpha_front/widgets/baseappbar.dart';
import 'package:alpha_front/widgets/basenavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MypageMain extends StatefulWidget {
  const MypageMain({super.key});

  @override
  State<MypageMain> createState() => _MypageMainState();
}

class _MypageMainState extends State<MypageMain> {

    File? _imageFile;
    final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

    String _nickname = "김유진"; // 초기에 입력한 거 가져와서 넣을 예정

  Future<void> _editInfo() async {
    final newNickname = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _EditInfoScreen(nickname: _nickname)),
    );

    if (newNickname != null) {
      setState(() {
        _nickname = newNickname;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppbar(title: '마이페이지'),
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : null,
                    child: _imageFile == null
                        ? Icon(Icons.person, size: 80, color: Colors.white)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Color(0xff118B50),
                      radius: 25,
                      child: Icon(Icons.camera_alt, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),

            Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    SizedBox(width: 20), 
                    Text(
                        _nickname,
                        style: TextStyle(
                            fontSize: 20,
                        ),
                    ),
                    IconButton(
                    icon: Icon(
                        Icons.edit,
                        size: 15,
                        color: Color(0xff118B50),
                    ),
                    onPressed: _editInfo,
                    ),
                  ],
                ),
            ),

            Container(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
                width: double.infinity,
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.white,
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
                        builder: (context) => MypageMyinfo())
                    );
                }, 
                child: Text(
                    '내정보',
                    style: TextStyle(
                    fontFamily: 'PretendartVariable',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff118B50),
                
                    ),
                ),
            ),
        ),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                width: double.infinity,
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.white,
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
                        builder: (context) => MypageMyscrap())
                    );
                }, 
                child: Text(
                    '내가 스크랩한 글',
                    style: TextStyle(
                    fontFamily: 'PretendartVariable',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff118B50),
                
                    ),
                ),
            ),
        ),

        Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
            width: double.infinity,
            child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.white,
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
                    builder: (context) => MypageMylike())
                );
            }, 
            child: Text(
                '내가 좋아요한 글',
                style: TextStyle(
                fontFamily: 'PretendartVariable',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xff118B50),
            
                ),
            ),
        ),
    ),

    Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
        width: double.infinity,
        child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Colors.white,
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
                builder: (context) => MypageMyinfo())
            );
        }, 
        child: Text(
            '내가 쓴 글',
            style: TextStyle(
            fontFamily: 'PretendartVariable',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xff118B50),
        
            ),
        ),
    ),
),

Container(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
    width: double.infinity,
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        backgroundColor: Colors.white,
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
            builder: (context) => MypageMyscrap())
        );
    }, 
    child: Text(
        '내가 쓴 댓글',
        style: TextStyle(
        fontFamily: 'PretendartVariable',
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Color(0xff118B50),
    
        ),
    ),
),
),

            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                width: double.infinity,
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.white,
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
                        builder: (context) => MypageMylike())
                    );
                }, 
                child: Text(
                    '내가 저장한 레시피',
                    style: TextStyle(
                    fontFamily: 'PretendartVariable',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff118B50),
                
                    ),
                ),
            ),
        ),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                width: double.infinity,
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
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
                        builder: (context) => loginScreen()) // 로그인 전 메인화면으로?? 로그인 화면으로??
                    );
                }, 
                child: Text(
                    '로그아웃',
                    style: TextStyle(
                    fontFamily: 'yg-jalnan',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                
                    ),
                ),
            ),
        ),
            ],
        ),
    ),
      // bottomNavigationBar: Basenavigationbar(currentIndex: 3,),
    );
    
  }
}



class _EditInfoScreen extends StatefulWidget {
  final String nickname;

  _EditInfoScreen({required this.nickname});

  @override
  _EditInfoScreenState createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<_EditInfoScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.nickname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(title: '정보 수정'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "닉네임",
                labelStyle: TextStyle(
                    fontFamily: 'PretendardVariable',
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _controller.text);
              },
              child: Text("수정"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}