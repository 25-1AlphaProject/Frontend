import 'dart:io';
import 'package:alpha_front/mypage/mypage_mywrite.dart';
import 'package:alpha_front/services/api_service.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/services.dart';
import 'package:alpha_front/Login/login.dart';
import 'package:alpha_front/mypage/mypage_mylike.dart';
import 'package:alpha_front/mypage/mypage_myscrap.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:alpha_front/user_provider.dart';
import 'package:provider/provider.dart';

class MypageMain extends StatefulWidget {
  const MypageMain({super.key});

  @override
  State<MypageMain> createState() => _MypageMainState();
}

class _MypageMainState extends State<MypageMain> {
  Uint8List? _imageBytes;
  File? _imageFile;
  String? _profileImageUrl; // 현재 프로필 이미지 URL
  final picker = ImagePicker();

Future<void> _pickImage() async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile == null) return;

  final bytes = await pickedFile.readAsBytes();
  final objectKey = "profile_${DateTime.now().millisecondsSinceEpoch}.jpeg";

  final presignedUrl = await ApiService().fetchPresignedUrl(objectKey);
  if (presignedUrl == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Presigned URL 가져오기 실패')),
    );
    return;
  }

  final uploadResponse = await http.put(
    Uri.parse(presignedUrl),
    headers: {
      'Content-Type': 'image/jpeg',
    },
    body: bytes,
  );

  if (uploadResponse.statusCode != 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('이미지 업로드 실패: ${uploadResponse.statusCode}')),
    );
    return;
  }

  final uploadedUrl = presignedUrl.split('?').first;

  final success = await ApiService.updateProfileImage(imageURL: uploadedUrl);
  if (success) {
    setState(() {
      _imageBytes = bytes;
      _imageFile = File(pickedFile.path);
      _profileImageUrl = uploadedUrl;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('프로필 이미지가 성공적으로 변경되었습니다.')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('프로필 이미지 변경 실패')),
    );
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

  

  Widget _buildMenuCard({
    required String title,
    required String iconPath,
    required VoidCallback onTap,

  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      color: Colors.white,
      child: ListTile(
        leading: Image.asset(
          iconPath,
          width: 22,
          height: 22,
        ),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Colors.black),
        ),
        onTap: onTap,
        trailing: const Icon(
          Icons.chevron_right, 
          color: Colors.black),
      ),
    );
  }

  void editDietInfo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DietInfoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3CB196), Color(0xFF9FD7CA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: 350,
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.white,
                                backgroundImage: _imageBytes != null
                                    ? MemoryImage(_imageBytes!)
                                    : (_profileImageUrl != null
                                        ? NetworkImage(_profileImageUrl!)
                                        : null) as ImageProvider?,
                                child: (_imageBytes == null &&
                                        _profileImageUrl == null)
                                    ? Image.asset(
                                        'assets/images/running_character.png',
                                        width: 80,
                                        height: 80,
                                      )
                                    : null,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: _pickImage,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Color(0xFF3CB196), width: 2),
                                    ),
                                    padding: const EdgeInsets.all(2),
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xFF3CB196),
                                      radius: 15,
                                      child: const Icon(Icons.add, color: Colors.white, size: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            userProvider.nickname,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 내 정보 카드
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.only(bottom: 18),
                      child: Column(
                        children: [
                          _buildMenuCard(
                            title: '내 정보 수정하기',
                            iconPath: '../assets/images/infoIcon.png',
                            onTap: _editInfo,
                          ),
                          const Divider(height: 1),
                          _buildMenuCard(
                            title: '맞춤 정보 수정하기',
                            iconPath: '../assets/images/dietIcon.png',
                            onTap: () => editDietInfo(context)
                          ),
                        ],
                      ),
                    ),
                    // 내 활동 카드
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.only(bottom: 18),
                      child: Column(
                        children: [
                          _buildMenuCard(
                            title: '내가 스크랩한 글',
                            iconPath: '../assets/images/scrabIcon.png',
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const MypageMyscrap()));
                            },
                          ),
                          const Divider(height: 1),
                          _buildMenuCard(
                            title: '내가 좋아요한 글',
                            iconPath: '../assets/images/likeIcon.png',
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const MypageMylike()));
                            },
                          ),
                          const Divider(height: 1),
                          _buildMenuCard(
                            title: '내가 쓴 글',
                            iconPath: '../assets/images/writeIcon.png',
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const MypageMywrite()));
                            },
                          ),
                          const Divider(height: 1),
                          _buildMenuCard(
                            title: '내가 저장한 레시피',
                            iconPath: '../assets/images/recipeIcon.png',
                            onTap: () {
                              // 저장한 레시피 화면으로 이동
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          '../assets/images/character.png',
                          width: 22,
                          height: 22,
                        ),
                        title: const Text(
                          '로그아웃',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const loginScreen()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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

  } catch (e, stackTrace) {
  debugPrint('❗ 오류 발생: $e');
  debugPrint('🧵 스택트레이스: $stackTrace');
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('회원 정보를 불러오지 못했습니다.')),
  );

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

class DietInfoScreen extends StatefulWidget {
  const DietInfoScreen({super.key});

  @override
  State<DietInfoScreen> createState() => _DietInfoScreenState();
}

class _DietInfoScreenState extends State<DietInfoScreen> {
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;

  late TextEditingController _allergyInputController;
  late TextEditingController _diseaseInputController;

  late String _selectedGender;
  late List<String> _allergies;
  late List<String> _diseases;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _allergyInputController = TextEditingController();
    _diseaseInputController = TextEditingController();
    _initializeData();
  }

Future<void> fetchAndSetDietInfo() async {
  try {
    final data = await ApiService.getUserDietInfo();
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (data != null) {
      final dietInfo = data['userDietInfo'] ?? {};

      userProvider.setUserDietInfo(
        age: data['age'] ?? 22,
        weight: (data['weight'] as num?)?.toDouble() ?? 60.0,
        height: (data['height'] as num?)?.toDouble() ?? 170.0,
        targetCalories: data['targetCalories'] ?? 1800,
        gender: data['gender'] ?? 'F',
        mealCount: (data['mealCounts'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ?? ['BREAKFAST', 'LUNCH'],
        allergies: (dietInfo['allergies'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ?? [],
        diseases: (dietInfo['diseases'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ?? [],
        preferredMenus: (dietInfo['preferredMenus'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ?? [],
        avoidIngredients: (dietInfo['avoidIngredients'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ?? [],
        healthGoal: data['healthGoal'] ?? 'DIET',
      );
    } else {
      throw Exception('데이터가 null입니다');
    }
  } catch (e) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUserDietInfo(
      age: 22,
      weight: 60.0,
      height: 170.0,
      targetCalories: 1800,
      gender: 'F',
      mealCount: ['BREAKFAST', 'LUNCH'],
      allergies: [],
      diseases: [],
      preferredMenus: [],
      avoidIngredients: [],
      healthGoal: 'DIET',
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('서버에서 정보를 불러오지 못해 기본값을 사용합니다.')),
      );
    }
  }
}


  Future<void> _initializeData() async {
    await fetchAndSetDietInfo();

    if (!mounted) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      _ageController = TextEditingController(text: userProvider.age.toString());
      _weightController = TextEditingController(text: userProvider.weight.toString());
      _heightController = TextEditingController(text: userProvider.height.toString());

      _selectedGender = userProvider.gender == 'F' ? '여성' : '남성';
      _allergies = List.from(userProvider.allergies);
      _diseases = List.from(userProvider.diseases);

      _isLoading = false;
    });
  }

  void _addToList(String value, List<String> list, TextEditingController controller) {
    if (value.isNotEmpty && !list.contains(value)) {
      setState(() => list.add(value));
      controller.clear();
    }
  }

  void _removeFromList(String item, List<String> list) {
    setState(() => list.remove(item));
  }

  Future<void> _editDietInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final genderCode = _selectedGender == '여성' ? 'F' : 'M';
    final age = int.tryParse(_ageController.text) ?? userProvider.age;
    final weight = double.tryParse(_weightController.text) ?? userProvider.weight;
    final height = double.tryParse(_heightController.text) ?? userProvider.height;

    // 사용자 입력 정보로 상태 업데이트
    userProvider.updateUserDietInfo(
      age: age,
      weight: weight,
      height: height,
      targetCalories: userProvider.targetCalories,
      gender: genderCode,
      mealCount: userProvider.mealCount,
      allergies: _allergies,
      diseases: _diseases,
      preferredMenus: userProvider.preferredMenus,
      avoidIngredients: userProvider.avoidIngredients,
      healthGoal: userProvider.healthGoal,
    );

    try {
      final success = await ApiService.updateDiet(
        selectedGender: genderCode,
        age: age,
        height: height,
        weight: weight,
        mealCount: userProvider.mealCount,
        targetCalories: userProvider.targetCalories,
        allergies: _allergies,
        diseases: _diseases,
        preferredMenus: userProvider.preferredMenus,
        avoidIngredients: userProvider.avoidIngredients,
        healthGoal: userProvider.healthGoal,
      );

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('정보가 저장되었습니다')),
        );
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('저장에 실패했습니다')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('저장 중 오류가 발생했습니다: $e')),
        );
      }
    }
  }

  Widget _buildChipList(String label, List<String> list, TextEditingController controller, void Function(String) onAdd) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: list.map((item) {
            return Chip(
              label: Text(item),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () => _removeFromList(item, list),
            );
          }).toList(),
        ),
        TextField(
          controller: controller,
          onSubmitted: onAdd,
          decoration: const InputDecoration(hintText: '추가 후 Enter'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('내 맞춤 정보 편집')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('내 맞춤 정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('나이'),
                  const SizedBox(width: 16),
                  Expanded(child: TextField(controller: _ageController, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChoiceChip(
                    label: const Text('남성'),
                    selected: _selectedGender == '남성',
                    onSelected: (_) => setState(() => _selectedGender = '남성'),
                  ),
                  ChoiceChip(
                    label: const Text('여성'),
                    selected: _selectedGender == '여성',
                    onSelected: (_) => setState(() => _selectedGender = '여성'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('몸무게'),
                  const SizedBox(width: 16),
                  Expanded(child: TextField(controller: _weightController, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('키'),
                  const SizedBox(width: 16),
                  Expanded(child: TextField(controller: _heightController, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 16),
              _buildChipList('알레르기', _allergies, _allergyInputController,
                  (value) => _addToList(value, _allergies, _allergyInputController)),
              _buildChipList('질환명', _diseases, _diseaseInputController,
                  (value) => _addToList(value, _diseases, _diseaseInputController)),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _editDietInfo,
                  child: const Text('저장하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
