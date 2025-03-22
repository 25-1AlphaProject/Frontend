import 'package:alpha_front/mypage/mypage_myinfo.dart';
import 'package:alpha_front/mypage/mypage_mylike.dart';
import 'package:alpha_front/mypage/mypage_myscrap.dart';
import 'package:flutter/material.dart';

class MypageMain extends StatefulWidget {
  const MypageMain({super.key});

  @override
  State<MypageMain> createState() => _MypageMainState();
}

class _MypageMainState extends State<MypageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              children: [
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

            ],
        ),
    ),

    );
    
  }
}