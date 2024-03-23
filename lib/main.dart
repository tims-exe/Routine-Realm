import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routine_realm/home.dart';

void main() async {
  //initialize hive
  await Hive.initFlutter();

  //open the box
  var box = await Hive.openBox('TestBox');

  runApp(const MyApp());

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Routine Realm',
      home: RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;

  List<Widget> pages = [
    HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
      body: pages[currentPage],
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: const Icon(Icons.add),
      ),*/
    );
  }
}
