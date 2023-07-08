import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/home.dart';
import 'package:task/screens/login.dart';
import 'package:task/screens/phone.dart';
import 'package:task/screens/signUp.dart';
import 'package:task/screens/verify.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: 'login',
      debugShowCheckedModeBanner: false,
      routes: {
        'phone': (context) => MyPhone(),
        'verify': (context) => MyVerify(),
        'home':(context)=>HomeScreen(),
        'login': (context)=>SignInScreen(),
        'signup': (context)=>SignUP(),
      },

    );
  }
}

