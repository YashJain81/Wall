import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wall/Auth/auth.dart';
import 'package:wall/Auth/login_or_register.dart';
import 'package:wall/Pages/register_page.dart';
import 'package:wall/firebase_options.dart';
import 'Pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
