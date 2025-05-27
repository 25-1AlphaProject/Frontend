import 'package:alpha_front/meal/mealAmount_edit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:alpha_front/services/api_service.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  Uint8List? _imageBytes;
  final picker = ImagePicker();
  final TextEditingController _amountController = TextEditingController();

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  String getMealType(DateTime now) {
    final hour = now.hour;
    if (hour >= 3 && hour < 12) return 'BREAKFAST';
    if (hour >= 12 && hour < 17) return 'LUNCH';
    return 'DINNER';
  }

  Future<void> uploadImageToS3() async {
    if (_imageBytes == null) return;

    final amount = double.tryParse(_amountController.text.trim());
      if (amount == null) {
        _showMessage('섭취량을 숫자로 입력해주세요.');
        return;
      }

    final now = DateTime.now();
    final mealType = getMealType(now);

    // 파일명 생성
    String objectKey = "upload_${DateTime.now().millisecondsSinceEpoch}.jpeg";

    final apiService = ApiService();
    final presignedUrl = await apiService.fetchPresignedUrl(objectKey);

    if (presignedUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Presigned URL을 가져오지 못했습니다.')),
      );
      return;
    }

    final response = await http.put(
      Uri.parse(presignedUrl),
      headers: {
        'Content-Type': 'image/jpeg',
      },
      body: _imageBytes,
    );

    // if (response.statusCode == 200) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('이미지 업로드 성공!')),
    //   );
    //   return true;
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('이미지 업로드 실패: ${response.statusCode}')),
    //   );
    //   return false;
    // }
    if (response.statusCode != 200) {
      _showMessage('이미지 업로드 실패: ${response.statusCode}');
      return;
    }


    final uploadedUrl = presignedUrl.split('?').first;

    final success = await ApiService.foodinfoCustom(
      amount,
      now,
      mealType,
      uploadedUrl,
    );
          if (success) {
        _showMessage('식사 정보 저장 완료!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MealamountEdit()),
        );
      } else {
        _showMessage('식사 정보 저장 실패');
      }
    }

  
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );

  }

  Widget showImage() {
    return Container(
      color: const Color(0xffd0cece),
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.width * 0.7,
      child: Center(
        child: _imageBytes == null
            ? Text('No image selected.')
            : Image.memory(_imageBytes!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 25.0),
          showImage(),
          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '섭취량 입력',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(Icons.add_a_photo, color: Color(0xff3CB196)),
                tooltip: 'pick Image',
                onPressed: () {
                  getImage(ImageSource.camera);
                },
              ),
              FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(Icons.wallpaper, color: Color(0xff3CB196)),
                tooltip: 'pick Image',
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff3CB196),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              side: BorderSide(color: Color(0xff3CB196), width: 1),
              elevation: 3,
            ),
            onPressed: uploadImageToS3,
            child: Text(
              '이미지 업로드',
              style: TextStyle(
                fontFamily: 'Pretendard-bold',
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
