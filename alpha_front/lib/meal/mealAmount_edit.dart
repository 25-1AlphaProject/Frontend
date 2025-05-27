import 'dart:io';

import 'package:alpha_front/meal/camera.dart';
import 'package:alpha_front/meal/meal_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class MealamountEdit extends StatefulWidget {
  const MealamountEdit({super.key});

  @override
  State<MealamountEdit> createState() => _MealamountEditState();
}

class _MealamountEditState extends State<MealamountEdit> {


  void _goToNext() {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Camera()),
    );
  }

  void _skip() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MealEdit()),
    );
  }

  File? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }

  Widget showImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffd0cece),

      ),
        width: MediaQuery.of(context).size.width*0.7,
        height: MediaQuery.of(context).size.width*0.7,
        child: Center(
          child: _image == null
            ? Text('No image selected.')
            : Image.file(File(_image!.path))
            ),
            );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration : BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff3CB196),
            Color(0xff8ED1C1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 33.0, right: 33.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
        
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffA3A2B0).withAlpha(20),
                        spreadRadius: -10,
                        blurRadius: 30,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      showImage(),
                      SizedBox(height: 15,),
                      Text(
                        '부대찌개',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.black,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xff3CB196),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '378 kcal',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.white,
                                fontFamily: 'Pretendard-bold',
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            '1 인분',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: 'Pretendard-bold',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                    SizedBox(height: 50,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                              // margin: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                              width: double.infinity,
                              child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffd9d9d9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                minimumSize: const Size(double.infinity, 50),
                                elevation: 3,
                                ),
                              onPressed: _skip,
                                child: Text(
                                '다시 인식',
                                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Color(0xff4d4d4d)),
                          
                              ),
                              ),
                          )
                        ),
                        SizedBox(width: 14,),
                        Expanded(
                          flex: 2,
                            child: Container(
                              // margin: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                              width: double.infinity,
                              child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffffffff),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                minimumSize: const Size(double.infinity, 50),
                                elevation: 3,
                                ),
                              onPressed: _goToNext,
                                child: Text(
                                '다음',
                                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                      color: Color(0xff3CB196),
                                    )
                                ),
                              ),
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}