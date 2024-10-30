import 'package:flutter/material.dart';
import 'package:pallaviapi/shopping/Userdetailpage.dart';

import 'package:pallaviapi/shopping/authpage.dart';
import 'package:pallaviapi/shopping/homepage.dart';

import 'get api/getapipractics.dart';
import 'get api/postpage.dart';






void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: UserdetailsScreen(),debugShowCheckedModeBanner: false,
    );
  }
}

