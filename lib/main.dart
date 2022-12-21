import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:spotright/presentation/page/home/home.dart';

void main() {
  runApp(const Spotright());
}

class Spotright extends StatelessWidget {
  const Spotright({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Spotright',
      routes: {
        '/home': (context) => const Home(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
    );
  }
}
