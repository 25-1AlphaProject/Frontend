import 'dart:io';
import 'package:alpha_front/mypage/mypage_mywrite.dart';
import 'package:flutter/services.dart'; 
import 'package:alpha_front/Login/login.dart';
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
  String _name = "김유진";
  String _id = "abcd";
  String _password = "1234";
  String _email = "abc@kookmin.ac.kr";
  String _phone_num = "010-1234-1234";

  int _age = 19;

Future<void> _editInfo() async {
  final updated = await Navigator.push<Map<String, String>>(
    context,
    MaterialPageRoute(
      builder: (context) => _EditInfoScreen(
        nickname: _nickname,
        name: _name,
        id: _id,
        password: _password,
        email: _email,
        phoneNum: _phone_num,
      ),
    ),
  );

  if (updated != null) {
    setState(() {
      _nickname  = updated['nickname']!; 
      _name      = updated['name']!;     
      _id        = updated['id']!;       
      _password  = updated['password']!; 
      _email     = updated['email']!;    
      _phone_num = updated['phoneNum']!; 
    });
  }
}

Future<void> _editMyinfo() async {
  // Map<String, String> → int 로 제네릭 변경
  final newAge = await Navigator.push<int>(
    context,
    MaterialPageRoute(
      builder: (context) => _EditMyinfoScreen(age: _age),
    ),
  );

  if (newAge != null) {
    setState(() {
      _age = newAge;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    backgroundImage:
                        _imageFile != null ? FileImage(_imageFile!) : null,
                    child: _imageFile == null
                        ? const Icon(Icons.person,
                            size: 80, color: Colors.white)
                        : null,
                  ),
                  const Positioned(
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
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  Text(
                    _nickname,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
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
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: const BorderSide(color: Color(0xff118B50), width: 1),
                  elevation: 3,
                ),
                onPressed: _editMyinfo,
                child: const Text(
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: const BorderSide(color: Color(0xff118B50), width: 1),
                  elevation: 3,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MypageMyscrap()));
                },
                child: const Text(
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: const BorderSide(color: Color(0xff118B50), width: 1),
                  elevation: 3,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MypageMylike()));
                },
                child: const Text(
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: const BorderSide(color: Color(0xff118B50), width: 1),
                  elevation: 3,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MypageMywrite()));
                },
                child: const Text(
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: const BorderSide(color: Color(0xff118B50), width: 1),
                  elevation: 3,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MypageMyscrap()));
                },
                child: const Text(
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: const BorderSide(color: Color(0xff118B50), width: 1),
                  elevation: 3,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MypageMylike()));
                },
                child: const Text(
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color(0xff118B50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: const BorderSide(color: Color(0xff118B50), width: 1),
                  elevation: 3,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const loginScreen()) // 로그인 전 메인화면으로?? 로그인 화면으로??
                      );
                },
                child: const Text(
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
  final String name;
  final String id;
  final String password;
  final String email;
  final String phoneNum;

  const _EditInfoScreen({
    required this.nickname,
    required this.name,
    required this.id,
    required this.password,
    required this.email,
    required this.phoneNum,
  });

  @override
  _EditInfoScreenState createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<_EditInfoScreen> {
  late TextEditingController _nicknameController;
  late TextEditingController _nameController;
  late TextEditingController _idController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: widget.nickname);
    _nameController = TextEditingController(text: widget.name);
    _idController = TextEditingController(text: widget.id);
    _passwordController = TextEditingController(text: widget.password);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phoneNum);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _nameController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onSave() {
    Navigator.of(context).pop({
      'nickname': _nicknameController.text,
      'name': _nameController.text,
      'id': _idController.text,
      'password': _passwordController.text,
      'email': _emailController.text,
      'phoneNum': _phoneController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '정보 수정',
          style: TextStyle(
            color: Color(0xff118B50),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: '닉네임',
                labelStyle: TextStyle(
                  color: Color(0xff118B50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xff118B50),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xff118B50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: _nameController,
              decoration: InputDecoration(
                labelText: '이름',
                labelStyle: TextStyle(
                  color: Color(0xff118B50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xff118B50),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xff118B50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: _idController,
              decoration: InputDecoration(
                labelText: '아이디',
                labelStyle: TextStyle(
                  color: Color(0xff118B50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xff118B50),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xff118B50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호',
                labelStyle: TextStyle(
                  color: Color(0xff118B50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xff118B50),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xff118B50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: '이메일',
                labelStyle: TextStyle(
                  color: Color(0xff118B50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xff118B50),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xff118B50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: '전화번호',
                labelStyle: TextStyle(
                  color: Color(0xff118B50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xff118B50),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xff118B50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff118B50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                '저장',
                style: TextStyle(
                  color: Colors.white,
                ),),
            ),
          ],
        ),
      ),
    );
  }
}


class _EditMyinfoScreen extends StatefulWidget {
  final int age;

  const _EditMyinfoScreen({
    required this.age,
  });

  @override
  _EditMyinfoScreenState createState() => _EditMyinfoScreenState();
}

class _EditMyinfoScreenState extends State<_EditMyinfoScreen> {
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    // int → String
    _ageController = TextEditingController(text: widget.age.toString());
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  void _onSave() {
    // 입력값을 int로 변환
    final newAge = int.tryParse(_ageController.text) ?? widget.age;
    Navigator.of(context).pop(newAge);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('정보 수정')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '나이',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              // 입력 중에 숫자만 받도록 필터링
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _onSave,
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
