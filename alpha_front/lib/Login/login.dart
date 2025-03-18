import 'package:flutter/material.dart';

class loginScreen extends StatelessWidget {
  const loginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizotal: 30.0),
          child: Column(
            mainAxisAlignmet: MainAxisAlignmet.center,
            children: [
              Text(
                '척척박사',
                style: TextStyle(
                  fontFamily: 'yg-jalnan',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ), //앱명
              TetxtFild(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '아이디',
                  hintStyle: TextStyle(
                    fontFamily: 'PretendardBariable',
                    color: Colors.grey.shade400,
                  ),
                  filled: true,
                  fillColor: colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ), // 아이디
              const SizedBox(height: 15),
              TextFild(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '비밀번호',
                  hintStyle: TextStyle(
                    fontFamily: 'PretendardBariable',
                    color: Colors.grey.shade400,
                  ),
                  filled: true,
                  fillColor: colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ), // 비번
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                ),
                child: Text(
                  "로그인",
                  style: TextStyle(
                    fontFamily: "PretendardVariable",
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ), //로그인 버튼
              TextButton(
                onPressed: () {},
                chlid: Text(
                  '아이디 / 비밀번호 찾기',
                  style: TextStyle(
                    fontFamily: 'PretendardVariable',
                    color: Colors.green,
                  ),
                ),
              ), //아이디/비밀번호 찾기 버튼
              TextButton(
                onPressed: () {},
                chlid: Text(
                  '아직 회원이 아니신가요? 회원가입하기',
                  style: TextStyle(
                    fontFamily: 'PretendardVariable',
                    color: Colors.green,
                  ),
                ),
              ), // 회원가입 버튼
            ],
          ),
        ),
      ),
    );
  }
}
