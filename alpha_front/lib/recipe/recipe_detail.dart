import 'package:alpha_front/widgets/baseappbar.dart';
import 'package:alpha_front/widgets/basenavigationbar.dart';
import 'package:flutter/material.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({super.key});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppbar(title: '레시피'),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: const Image(
              image: AssetImage(
                // image 변경 - url => network
                'alpha_front/assets/images/example_recipe.png',
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.5,
            maxChildSize: 1.0,
            builder: (context, ScrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  controller: ScrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const Text(
                        '닭가슴살 야채볶음밥',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
                        children: [
                          Icon(Icons.access_time, size: 16),
                          SizedBox(width: 4),
                          Text('15분 이내'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '재료',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
//       body: Container(
//         width: double.infinity,
//         height: MediaQuery.of(context).size.height * 0.35,
//         child: Stack(
//           children: [
//             Image(
//               image : AssetImage( // image 변경 - url => network
//                 'alpha_front/assets/images/example_recipe.png',
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               height: 200, // 임의 설정
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15),
//                   topRight: Radius.circular(15)
//                 )
//               ),
//             )
//           ],
//         )
//       ),
    );
  }
}
