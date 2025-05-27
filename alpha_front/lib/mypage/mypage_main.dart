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

  List<String> meal_count = [];
  List<String> _selectedDisease = [];
  TextEditingController _diseasesearchController = TextEditingController();


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

  Future<void> editDietInfo() async {
    final updated = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (context) => EditDietInfoScreen()),
    );
    if (updated != null) {
      // Provider의 정보도 즉시 갱신
      Provider.of<UserProvider>(context, listen: false).updateUserDietInfo(
        age: int.parse(updated['age'].toString()),
        height: double.parse(updated['height'].toString()),
        weight: double.parse(updated['weight'].toString()),
        gender: updated['gender'],
        mealCount: List<String>.from(updated['mealCount'] ?? []),
        targetCalories: int.parse(updated['targetCalories'].toString()),
        allergies: List<String>.from(updated['allergies'] ?? []),
        diseases: List<String>.from(updated['diseases'] ?? []),
        preferredMenus: List<String>.from(updated['preferredMenus'] ?? []),
        avoidIngredients: List<String>.from(updated['avoidIngredients'] ?? []),
        healthGoal: updated['healthGoal'],
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
                    onPressed:
                    editDietInfo,
                    child: Text(
                      '내정보',
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
  try {
    final userData = await ApiService.getUserInfo();
    
    if (!mounted) return; // 화면이 사라진 후 콜백 방지
    
    if (userData == null) {
      throw Exception('서버에서 빈 응답을 받았습니다');
    }

    setState(() {
      _nicknameController.text = userData['nickname'] ?? '';
      _nameController.text = userData['name'] ?? '';
      _passwordController.text = '';
      _idController.text = userData['username'] ?? '';
      _emailController.text = userData['email'] ?? '';
      _isLoading = false;
    });

  } catch (e, stack) {
    print('사용자 데이터 조회 실패: $e');
    print('Stack trace: $stack');

    if (!mounted) return;
    
    setState(() => _isLoading = false);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_getErrorMessage(e)),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
    
    Navigator.of(context).pop();
  }
}


String _getErrorMessage(dynamic error) {
  if (error is SocketException) {
    return '인터넷 연결을 확인해주세요';
  } else if (error is FormatException) {
    return '데이터 처리 중 오류가 발생했습니다';
  }
  return '사용자 정보를 불러오는 데 실패했습니다';
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

  void _onSaveInfo() async {
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
                      onPressed: _onSaveInfo,
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


class EditDietInfoScreen extends StatefulWidget {

  @override
  EditDietInfoScreenState createState() => EditDietInfoScreenState();
}

class EditDietInfoScreenState extends State<EditDietInfoScreen> {
  late TextEditingController _ageController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _targetCaloriescontroller;
  late TextEditingController _allergiesSearchController;
  late TextEditingController _preferredMenusSearchController;
  late TextEditingController _avoidIngredientsSearchController;
  late TextEditingController _diseasesearchController;

  bool _isLoading = true;

  String? _gender;
  List<String> _mealCount = [];
  List<String> _selectedAllergy = [];
  List<String> _selectedDisease = [];
  List<String> _selectedLikeFood = [];
  List<String> _selectedHateFood = [];
  String? _healthGoal;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _fetchUserDietData();
  }

  void _initControllers() {
    _ageController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
    _targetCaloriescontroller = TextEditingController();
    _allergiesSearchController = TextEditingController();
    _preferredMenusSearchController = TextEditingController();
    _avoidIngredientsSearchController = TextEditingController();
    _diseasesearchController = TextEditingController();
  }

  Future<void> _fetchUserDietData() async {
    try {
    final userDietData = await ApiService.getUserDietInfo();

    if (!mounted) return; // 화면이 사라진 경우 중단

    if (userDietData == null) {
        setState(() {
          _gender = null;
          _mealCount = [];
          _selectedAllergy = [];
          _selectedDisease = [];
          _selectedLikeFood = [];
          _selectedHateFood = [];
          _healthGoal = null;
          _isLoading = false;
        });
      throw Exception('API 응답이 null입니다');
    }

      setState(() {
        _ageController.text = userDietData['age']?.toString() ?? '';
        _heightController.text = userDietData['height']?.toString() ?? '';
        _weightController.text = userDietData['weight']?.toString() ?? '';
        _targetCaloriescontroller.text = userDietData['targetCalories']?.toString() ?? '';
        _gender = userDietData['gender'] ?? "";
        
        _mealCount = (userDietData['mealCounts'] is List)
            ? List<String>.from(userDietData['mealCounts'].map((e) => e.toString()))
            : (userDietData['mealCounts']?.toString().split(',') ?? []);
        
        final userDietInfo = userDietData['userDietInfo'] ?? {};
        _selectedAllergy = (userDietInfo['allergies'] is List)
            ? List<String>.from(userDietInfo['allergies'].map((e) => e.toString()))
            : (userDietInfo['allergies']?.toString().split(',') ?? []);
        _selectedDisease = (userDietInfo['diseases'] is List)
            ? List<String>.from(userDietInfo['diseases'].map((e) => e.toString()))
            : (userDietInfo['diseases']?.toString().split(',') ?? []);
        _selectedLikeFood = (userDietInfo['preferredMenus'] is List)
            ? List<String>.from(userDietInfo['preferredMenus'].map((e) => e.toString()))
            : (userDietInfo['preferredMenus']?.toString().split(',') ?? []);
        _selectedHateFood = (userDietInfo['avoidIngredients'] is List)
            ? List<String>.from(userDietInfo['avoidIngredients'].map((e) => e.toString()))
            : (userDietInfo['avoidIngredients']?.toString().split(',') ?? []);
            
        _healthGoal = userDietData['healthGoal'] ?? "DIET";
        _isLoading = false;
      });
    } catch (e, stack) {
      print(' 다이어트 정보 조회 오류: $e');
      print(' Stack trace: $stack');

      if (!mounted) return;

      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_getErrorMessage(e)),
          backgroundColor: Colors.red,
        ),
      );
      
      Navigator.of(context).pop();
    }
  }

    String _getErrorMessage(dynamic error) {
    if (error is SocketException) return '인터넷 연결을 확인해주세요';
    if (error is FormatException) return '데이터 처리 오류 발생';
    return '정보를 불러오는 데 실패했습니다';
  }

  void _onSaveDietInfo() async {
    final success = await ApiService.updateDiet(
      age: int.tryParse(_ageController.text) ?? 0,
      height: double.tryParse(_heightController.text) ?? 0.0,
      weight: double.tryParse(_weightController.text) ?? 0.0,
      targetCalories: int.tryParse(_targetCaloriescontroller.text) ?? 0,
      selectedGender: _gender ?? "F",
      mealCount: _mealCount,
      allergies: _selectedAllergy,
      diseases: _selectedDisease,
      preferredMenus: _selectedLikeFood,
      avoidIngredients: _selectedHateFood,
      healthGoal: _healthGoal ?? "DIET",
    );
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원 다이어트 정보가 수정되었습니다.')),
      );
      Navigator.of(context).pop({
        'age': int.parse(_ageController.text),
        'height': double.parse(_heightController.text),
        'weight': double.parse(_weightController.text),
        'targetCalories': int.parse(_targetCaloriescontroller.text),
        'gender': _gender,
        'mealCount': _mealCount,
        'allergies': _selectedAllergy,
        'diseases': _selectedDisease,
        'preferredMenus': _selectedLikeFood,
        'avoidIngredients': _selectedHateFood,
        'healthGoal': _healthGoal,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원정보 수정에 실패했습니다.')),
      );
    }
  }

  final Map<String, String> mealNameMap = {
    '아침': 'BREAKFAST',
    '점심': 'LUNCH',
    '저녁': 'DINNER',
  };

  Widget _buildMealButton(String mealNameKor) {
    final String mealKey = mealNameMap[mealNameKor]!;
    final bool isSelected = _mealCount.contains(mealKey);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        backgroundColor:
            isSelected ? const Color(0xff3CB196) : const Color(0xffECF8F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
      ),
      onPressed: () {
        setState(() {
          if (isSelected) {
            _mealCount.remove(mealKey);
          } else {
            _mealCount.add(mealKey);
          }
        });
      },
      child: Text(
        mealNameKor,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontFamily: 'Pretendard-bold',
              color: isSelected ? Colors.white : const Color(0xff3CB196),
            ),
      ),
    );
  }

  // 질환명 관리 메서드들
  void _addDisease(String input) {
    if (input.trim().isEmpty) return;
    List<String> terms = input
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    setState(() {
      for (var term in terms) {
        if (!_selectedDisease.contains(term)) {
          _selectedDisease.add(term);
        }
      }
    });
    _diseasesearchController.clear();
  }

  void _removeDisease(String term) {
    setState(() {
      _selectedDisease.remove(term);
    });
  }

  // 알레르기 관리 메서드들 (동일한 패턴)
  void _addAllergy(String input) {
    if (input.trim().isEmpty) return;
    List<String> terms = input
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    setState(() {
      for (var term in terms) {
        if (!_selectedAllergy.contains(term)) {
          _selectedAllergy.add(term);
        }
      }
    });
    _allergiesSearchController.clear();
  }

  void _removeAllergy(String term) {
    setState(() {
      _selectedAllergy.remove(term);
    });
  }

  // 선호 식품 관리 메서드들
  void _addLikeFood(String input) {
    if (input.trim().isEmpty) return;
    List<String> terms = input
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    setState(() {
      for (var term in terms) {
        if (!_selectedLikeFood.contains(term)) {
          _selectedLikeFood.add(term);
        }
      }
    });
    _preferredMenusSearchController.clear();
  }

  void _removeLikeFood(String term) {
    setState(() {
      _selectedLikeFood.remove(term);
    });
  }

  // 기피 식품 관리 메서드들
  void _addHateFood(String input) {
    if (input.trim().isEmpty) return;
    List<String> terms = input
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    setState(() {
      for (var term in terms) {
        if (!_selectedHateFood.contains(term)) {
          _selectedHateFood.add(term);
        }
      }
    });
    _avoidIngredientsSearchController.clear();
  }

  void _removeHateFood(String term) {
    setState(() {
      _selectedHateFood.remove(term);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xff3CB196),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(33.0),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 기본 정보 입력 필드들
                TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '나이',
                    labelStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Color(0xff3CB196)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xff3CB196)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xff3CB196)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _heightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: '키(cm)',
                    labelStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Color(0xff3CB196)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xff3CB196)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xff3CB196)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _weightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: '체중 (kg)',
                    labelStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Color(0xff3CB196)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xff3CB196)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xff3CB196)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _targetCaloriescontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '목표 칼로리',
                    labelStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Color(0xff3CB196)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xff3CB196)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xff3CB196)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
      
                // 성별 선택 버튼 (_gender 사용)
                Text(
                  '성별',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Color(0xff3CB196),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                        backgroundColor: _gender == "F"
                            ? const Color(0xff3CB196)
                            : Color(0xffECF8F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        setState(() {
                          _gender = "F";
                        });
                      },                   
                      child: Text(
                        '여자',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: 'Pretendard-bold',
                          color: _gender == "F"
                              ? Colors.white
                              : const Color(0xff3CB196),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                        backgroundColor: _gender == "M"
                            ? const Color(0xff3CB196)
                            : Color(0xffECF8F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        setState(() {
                          _gender = "M";
                        });
                      },                      
                      child: Text(
                        '남자',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: 'Pretendard-bold',
                          color: _gender == "M"
                              ? Colors.white
                              : const Color(0xff3CB196),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
      
                // 식사 횟수 선택
                Text(
                  '식사 횟수',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Color(0xff3CB196),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMealButton('아침'),
                    _buildMealButton('점심'),
                    _buildMealButton('저녁'),
                  ],
                ),
                const SizedBox(height: 20),
      
                // 알레르기 정보
                Text(
                  '알레르기',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Color(0xff3CB196),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _allergiesSearchController,
                  decoration: InputDecoration(
                    hintText: "알러지 검색 후 엔터",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),
                    border: UnderlineInputBorder(),
                  ),
                  onSubmitted: _addAllergy,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  children: _selectedAllergy.map((term) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
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
                          onTap: () => _removeAllergy(term),
                          child: Icon(Icons.close, color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 20),
      
                // 질환명
                Text(
                  '질환명',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Color(0xff3CB196),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _diseasesearchController,
                  decoration: InputDecoration(
                    hintText: '질환명 검색 후 엔터',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff000000)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff3CB196)),
                    ),
                  ), 
                  onSubmitted: _addDisease,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  children: _selectedDisease.map((term) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
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
                          onTap: () => _removeDisease(term),
                          child: Icon(Icons.close, color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 20),
      
                // 선호 식품
                Text(
                  '선호 식품',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Color(0xff3CB196),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _preferredMenusSearchController,
                  decoration: InputDecoration(
                    hintText: "선호 식품 검색 후 엔터",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),
                    border: UnderlineInputBorder(),
                  ),
                  onSubmitted: _addLikeFood,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  children: _selectedLikeFood
                      .map(
                        (term) => ElevatedButton(
                          style: ElevatedButton.styleFrom(
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
                const SizedBox(height: 20),
      
                // 기피 식품
                Text(
                  '기피 식품',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Color(0xff3CB196),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _avoidIngredientsSearchController,
                  decoration: InputDecoration(
                    hintText: "기피 식품 검색 후 엔터",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xffb6b6b6)),
                    border: UnderlineInputBorder(),
                  ),
                  onSubmitted: _addHateFood,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  children: _selectedHateFood
                      .map(
                        (term) => ElevatedButton(
                          style: ElevatedButton.styleFrom(
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
                const SizedBox(height: 24),
      
                // 저장 버튼
                Center(
                  child: Container(
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
                      onPressed: _onSaveDietInfo,
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
      ),
    );
  }
}
