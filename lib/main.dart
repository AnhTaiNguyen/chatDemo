import 'package:flutter/material.dart';
import 'package:Login_App/Screen/login_screen.dart';
import 'package:Login_App/Screen/login_screen.dart';

import 'Screen/chat_screen.dart';
import 'Screen/home_screen.dart';
import 'Screen/sign_up.dart';
import 'Widgets/favorite_contacts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: LoginScreen(),
    );
  }
}
