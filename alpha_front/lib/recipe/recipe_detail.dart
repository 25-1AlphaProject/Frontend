import 'package:alpha_front/widgets/base_app_bar.dart';
import 'package:alpha_front/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({super.key});

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: BaseAppbar(title: '레시피'),
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
