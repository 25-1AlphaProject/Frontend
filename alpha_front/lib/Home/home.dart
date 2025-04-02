import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/widgets/baseappbar.dart';
import 'package:alpha_front/widgets/kcalWidget.dart';
import 'package:alpha_front/widgets/dietManagement.dart';
import 'package:alpha_front/widgets/basenavigationbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onKcalWidgetTap() {
    print("KcalWidget이 클릭됨");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => const 어디로...()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: const Basenavigationbar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 28),
            // Week(),
            const SizedBox(height: 28),
            KcalWidget(
              onTap: _onKcalWidgetTap,
            ),
            const SizedBox(height: 20),
            // Expanded(child: DietManagementWidget()),
          ],
        ),
      ),
    );
  }
}
