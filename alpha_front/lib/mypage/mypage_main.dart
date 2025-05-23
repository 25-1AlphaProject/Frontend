import 'dart:io';
import 'package:alpha_front/mypage/mypage_mywrite.dart';
import 'package:alpha_front/services/api_service.dart';
import 'package:flutter/services.dart'; 
import 'package:alpha_front/Login/login.dart';
import 'package:alpha_front/mypage/mypage_mylike.dart';
import 'package:alpha_front/mypage/mypage_myscrap.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alpha_front/user_provider.dart';
import 'package:provider/provider.dart';

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

Future<void> _editInfo() async {
    final updated = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => _EditInfoScreen()),
    );
    if (updated != null) {
      // Provider의 정보도 즉시 갱신
      Provider.of<UserProvider>(context, listen: false).updateUserInfo(
        nickname: updated['nickname']!,
        password: updated['password']!,
      );
      setState(() {}); // 화면 갱신
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);


    return Padding(
      padding: EdgeInsets.fromLTRB(33, 0, 33, 0),
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: BaseAppbar(title: '마이페이지'),
        body: SingleChildScrollView(
          child: Center(
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
                          backgroundColor: Color(0xff3CB196),
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
                        userProvider.nickname,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 15,
                          color: Color(0xff3CB196),
                        ),
                        onPressed: _editInfo,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // side: const BorderSide(color: Color(0xff3CB196), width: 1),
                      elevation: 3,
                    ),
                    onPressed: (){},
                    //  _editMyinfo,
                    child: Text(
                      '내정보',
                      // style: TextStyle(
                      //   fontFamily: 'PretendardVariable',
                      //   fontSize: 15,
                      //   fontWeight: FontWeight.bold,
                      //   color: Color(0xff3CB196),
                      // ),
                      style: Theme.of(context)
                        .textTheme
                        .labelMedium!.
                        copyWith(color: Colors.black),                          
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // side: const BorderSide(color: Color(0xff3CB196), width: 1),
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MypageMyscrap()));
                    },
                    child: Text(
                      '내가 스크랩한 글',
                      // style: TextStyle(
                      //   fontFamily: 'PretendartVariable',
                      //   fontSize: 15,
                      //   fontWeight: FontWeight.bold,
                      //   color: Color(0xff3CB196),
                      // ),
                      style: Theme.of(context)
                        .textTheme
                        .labelMedium!.
                        copyWith(color: Colors.black),                           
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // side: const BorderSide(color: Color(0xff3CB196), width: 1),
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MypageMylike()));
                    },
                    child: Text(
                      '내가 좋아요한 글',
                      // style: TextStyle(
                      //   fontFamily: 'PretendartVariable',
                      //   fontSize: 15,
                      //   fontWeight: FontWeight.bold,
                      //   color: Color(0xff3CB196),
                      // ),
                      style: Theme.of(context)
                        .textTheme
                        .labelMedium!.
                        copyWith(color: Colors.black),                           
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // side: const BorderSide(color: Color(0xff3CB196), width: 1),
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MypageMywrite()));
                    },
                    child: Text(
                      '내가 쓴 글',
                      // style: TextStyle(
                      //   fontFamily: 'PretendartVariable',
                      //   fontSize: 15,
                      //   fontWeight: FontWeight.bold,
                      //   color: Color(0xff3CB196),
                      // ),
                      style: Theme.of(context)
                        .textTheme
                        .labelMedium!.
                        copyWith(color: Colors.black),                           
                      ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // side: const BorderSide(color: Color(0xff3CB196), width: 1),
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MypageMyscrap()));
                    },
                    child: Text(
                      '내가 쓴 댓글',
                      // style: TextStyle(
                      //   fontFamily: 'PretendartVariable',
                      //   fontSize: 15,
                      //   fontWeight: FontWeight.bold,
                      //   color: Color(0xff3CB196),
                      // ),
                      style: Theme.of(context)
                        .textTheme
                        .labelMedium!.
                        copyWith(color: Colors.black),                           
                        ),             
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // side: const BorderSide(color: Color(0xff3CB196), width: 1),
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MypageMylike()));
                    },
                    child: Text(
                      '내가 저장한 레시피',
                      // style: TextStyle(
                      //   fontFamily: 'PretendartVariable',
                      //   fontSize: 15,
                      //   fontWeight: FontWeight.bold,
                      //   color: Color(0xff3CB196),
                      // ),
                      style: Theme.of(context)
                        .textTheme
                        .labelMedium!.
                        copyWith(color: Colors.black),                    
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // side: const BorderSide(color: Color(0xff3CB196), width: 1),
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
                    child: Text(
                      '로그아웃',
                      style: Theme.of(context)
                        .textTheme
                        .labelMedium!.
                        copyWith(color: Colors.red)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: Basenavigationbar(currentIndex: 3,),
      ),
    );
  }
}

class _EditInfoScreen extends StatefulWidget {

  // const _EditInfoScreen({
  //   required this.id,
  // });

  @override
  _EditInfoScreenState createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<_EditInfoScreen> {
  late TextEditingController _nicknameController;
  late TextEditingController _nameController;
  late TextEditingController _idController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // userId = userProvider.id;    
    _initControllers();
    _fetchUserData();
  }
  
  void _initControllers() {
    _nicknameController = TextEditingController();
    _nameController = TextEditingController();
    _idController = TextEditingController(); // ID는 고정
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  
  Future<void> _fetchUserData() async {
    // final userData = await ApiService.getUserInfo(userId);
  final userData = await ApiService.getUserInfo();

    if (userData != null) {
      setState(() {
        _nicknameController.text = userData['nickname'] ?? '';
        _nameController.text = userData['name'] ?? '';
        _passwordController.text = '';
        _idController.text = userData['username'] ?? '';
        _emailController.text = userData['email'] ?? '';
        _isLoading = false;
      });
    } else {
      // 실패
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('사용자 정보를 불러오는 데 실패했습니다.')),
      );
      Navigator.of(context).pop(); // 뒤로 가기
    }
  }

  // @override
  // void dispose() {
  //   _nicknameController.dispose();
  //   _nameController.dispose();
  //   _idController.dispose();
  //   _passwordController.dispose();
  //   _emailController.dispose();
  //   super.dispose();
  // }

  void _onSave() async {
    final success = await ApiService.updateUser(
      password: _passwordController.text,
      nickname: _nicknameController.text,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원정보가 수정되었습니다.')),
      );
      Navigator.of(context).pop({
        'nickname': _nicknameController.text,
        'password': _passwordController.text,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원정보 수정에 실패했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Padding(
      padding: const EdgeInsets.all(33.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: const Text(
        //     '정보 수정',
        //     style: TextStyle(
        //       color: Color(0xff3CB196),
        //     ),
        //   ),
        // ),
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
                  labelStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!.
                        copyWith(color: Color(0xff3CB196)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xff3CB196),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xff3CB196),
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
                  labelStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!.
                        copyWith(color: Color(0xff3CB196)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xff3CB196),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xff3CB196),
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
                  labelStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!.
                        copyWith(color: Color(0xff3CB196)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xff3CB196),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xff3CB196),
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
                  labelStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!.
                        copyWith(color: Color(0xff3CB196)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xff3CB196),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xff3CB196),
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
                  labelStyle:Theme.of(context)
                        .textTheme
                        .bodyMedium!.
                        copyWith(color: Color(0xff3CB196)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xff3CB196),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xff3CB196),
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 16),
              // TextField(
              //   style: Theme.of(context).textTheme.bodyMedium,
              //   controller: _phoneController,
              //   keyboardType: TextInputType.phone,
              //   decoration: InputDecoration(
              //     labelText: '전화번호',
              //     labelStyle: Theme.of(context)
              //           .textTheme
              //           .bodyMedium!.
              //           copyWith(color: Color(0xff3CB196)),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20),
              //       borderSide: BorderSide(
              //         color: Color(0xff3CB196),
              //       ),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20),
              //       borderSide: BorderSide(
              //         color: Color(0xff3CB196),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 24),
                Center(
                  child: Container(
                    // margin: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                    width: double.infinity,
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff3CB196),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      minimumSize: const Size(double.infinity, 50),
                      elevation: 3,
                      ),
                      onPressed: _onSave,
                      child: Text(
                        '저장',
                          style: Theme.of(context).textTheme.labelMedium,
      
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


// class _EditMyinfoScreen extends StatefulWidget {
//   final int age;
//   final double weight;
//   final double height;
//   final int targetCalories;

//   const _EditMyinfoScreen({
//     required this.age,
//     required this.weight,
//     required this.height,
//     required this.targetCalories,
//   });

//   @override
//   _EditMyinfoScreenState createState() => _EditMyinfoScreenState();
// }

// class _EditMyinfoScreenState extends State<_EditMyinfoScreen> {
//   late TextEditingController _ageController;
//   late TextEditingController _weightController;
//   late TextEditingController _heightController;
//   late TextEditingController _caloriesController;

//   // 체중, 성별, 키, 알레르기, 식단관리, 선호, 기피, 칼로리, 목표

//   @override
//   void initState() {
//     super.initState();
//     // int → String
//     _ageController = TextEditingController(text: widget.age.toString());
//   }

//   @override
//   void dispose() {
//     _ageController.dispose();
//     super.dispose();
//   }

//   void _onSave() {
//     final newAge = int.tryParse(_ageController.text) ?? widget.age;
//     Navigator.of(context).pop(newAge);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: AppBar(title: const Text('정보 수정')),
//       body: Padding(
//         padding: const EdgeInsets.all(33),
//         child: Column(
//           children: [
//             TextField(
//               controller: _ageController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: '나이',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               // 입력 중에 숫자만 받도록 필터링
//               inputFormatters: [
//                 FilteringTextInputFormatter.digitsOnly,
//               ],
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: _onSave,
//               child: const Text('저장'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
