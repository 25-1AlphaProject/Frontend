import 'package:alpha_front/Home/home.dart';
import 'package:alpha_front/layout.dart';
import 'package:alpha_front/mypage/mypage_main.dart';
import 'package:alpha_front/recipe/recipe_list.dart';
import 'package:alpha_front/report/report_main.dart';
import 'package:alpha_front/survey/pre_survey.dart';
import 'package:alpha_front/Login/login.dart';
import 'package:alpha_front/SignUp/signup.dart';
import 'package:alpha_front/survey/pre_survey1.dart';
import 'package:alpha_front/survey/pre_survey5.dart';
import 'package:flutter/material.dart';
import 'package:alpha_front/Splash/splash.dart';
import 'package:alpha_front/SignUp/signup_loading.dart';
import 'package:alpha_front/recipe/recipe_description.dart';
import 'user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers : [
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: CCBS(),
    ),
  );
}

class CCBS extends StatelessWidget {
  const CCBS({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '척척밥사',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
            bodyMedium: TextStyle(
              // 본문 (사전설문 글) / 본문
              fontFamily: 'Pretendard-regular',
              fontSize: 17,
            ),
            titleLarge: TextStyle(
              // 앱바 척척밥사
              fontFamily: 'yg-jalnan',
              fontSize: 30,
              color: Color(0xff3cb196),
            ),
            bodyLarge: TextStyle(
              // 화면 내 대제목
              fontFamily: 'Pretendard-regular',
              fontSize: 36,
              color: Colors.black,
            ),
            labelMedium: TextStyle(
              fontFamily: 'Pretendard-bold',
              fontSize: 20,
              color: Colors.white,
            )),
        // Theme 설정
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff118B50)),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: '척척밥사'),
      // home: Survey(),
      // home: const MypageMain(),
      // home: const loginScreen(),
      // home: const signupScreen(),
      // home: const HomeScreen(),
      home: Layout(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
