import 'package:flutter/material.dart';
import 'package:sahityadesign/view/gita_chapter.dart';
import 'package:sahityadesign/view/gita_screen.dart';
import 'package:sahityadesign/view/sahitya_home.dart';
import 'package:sahityadesign/view/saved_itemscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SahityaHome(),
    );
  }
}