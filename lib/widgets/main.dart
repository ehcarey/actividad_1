import 'package:flutter/material.dart';

import 'package:actividad_1/screen/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carros Eléctricos',
      home: LoginScreen(),
    );
  }
}
