import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/services/api_service.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class PostCreatePage extends StatefulWidget {
  const PostCreatePage({super.key});

  @override
  State<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  List<Uint8List> _imageBytesList = [];
  final picker = ImagePicker();

  Future<void> getImages() async {
    final List<XFile> images = await picker.pickMultiImage();
    final List<Uint8List> bytesList = [];
    for (final image in images) {
      final bytes = await image.readAsBytes();
      bytesList.add(bytes);
    }

    setState(() {
      _imageBytesList = bytesList;
    });
  }

  Future<List<String>> putImages(List<Uint8List> imageBytesList) async {
    List<String> uploadedUrls = [];

    for (final bytes in imageBytesList) {
      final objectKey =
          "communityWrite_${DateTime.now().millisecondsSinceEpoch}.jpeg";

      final presignedUrl = await ApiService().fetchPresignedUrl(objectKey);
      if (presignedUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Presigned URL 가져오기 실패')),
        );
        return [];
      }

      final uploadResponse = await http.put(
        Uri.parse(presignedUrl),
        headers: {'Content-Type': 'image/jpeg'},
        body: bytes,
      );

      if (uploadResponse.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미지 업로드 실패: ${uploadResponse.statusCode}')),
        );
        return [];
      }

      final uploadedUrl = presignedUrl.split('?').first;
      uploadedUrls.add(uploadedUrl);
    }

    return uploadedUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(
        actionButton: TextButton(
          onPressed: () async {
            final imageUrls = await putImages(_imageBytesList);
            if (imageUrls.isEmpty && _imageBytesList.isNotEmpty) {
              // 이미지 있었는데 업로드 실패한 경우
              return;
            }

            final success = await ApiService.write(
              titleController.text,
              contentController.text,
              imageUrls, // 선택된 이미지 URL들 넣기
            );

            if (success) {
              Navigator.pop(context); // 글 작성 완료 후 페이지 닫기
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("글 작성에 실패했습니다.")),
              );
            }
          },
          child: const Text('완료'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: '글 제목을 입력하세요',
                hintStyle: TextStyle(
                  fontFamily: 'Pretendard-regular',
                  fontSize: 20,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText: '내용을 입력하세요',
                  hintStyle: TextStyle(
                    fontFamily: 'Pretendard-regular',
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            // const Text(
            //   '소분류 해시태그',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            const SizedBox(height: 12),
            IconButton(
              icon: const Icon(
                Icons.upload_rounded,
                color: Colors.teal,
                size: 25,
              ),
              onPressed: getImages, //사진 업로드
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _imageBytesList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.memory(_imageBytesList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
