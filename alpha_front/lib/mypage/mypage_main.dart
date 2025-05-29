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

  Future<void> editDietInfo() async {
    // ... 기존 코드와 동일
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
                            onTap: editDietInfo,
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
                    // 로그아웃 카드
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


