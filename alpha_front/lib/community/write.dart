import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/services/api_service.dart';
import 'package:alpha_front/widgets/base_app_bar.dart';

class PostCreatePage extends StatefulWidget {
  const PostCreatePage({super.key});

  @override
  State<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(
        actionButton: TextButton(
          onPressed: () async {
            final success = await ApiService.write(
              titleController.text,
              contentController.text,
              [], // 선택된 이미지 URL들 넣기
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
                  hintText: '내용을 입력하세요...',
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              '소분류 해시태그',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            IconButton(
              icon: const Icon(Icons.upload_rounded, color: Colors.teal),
              onPressed: () {
                // 사진 업로드 기능
              },
            ),
          ],
        ),
      ),
    );
  }
}
