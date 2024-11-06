import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahityadesign/controller/audio_controller.dart';
import 'package:sahityadesign/controller/bookmark_provider.dart';
import 'package:sahityadesign/controller/settings_controller.dart';
import 'package:sahityadesign/controller/share_verse.dart';
import 'package:sahityadesign/view/gita_chapter/gitachapter.dart';

import 'controller/progress_controller.dart';

void main() async{

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AudioPlayerManager(),),
    ChangeNotifierProvider(create: (context) => ShareVerse(),),
    ChangeNotifierProvider(create: (context) => BookmarkProvider(),),
    ChangeNotifierProvider(create: (context) => SettingsProvider(),),
    ChangeNotifierProvider(create: (_) => ProgressProvider()),
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GitaChapter(isToast: false,)
    );
  }
}