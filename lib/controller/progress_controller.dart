import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressProvider with ChangeNotifier {
  String _chapterName = '';
  String _shlokNumber = "";

  String get chapterName => _chapterName;
  String get shlokNumber => _shlokNumber;

  ProgressProvider() {
    loadProgress(); // Load the progress when the provider is initialized
  }

  // Save the progress to SharedPreferences
  Future<void> saveProgress(String chapterName, String shlokNumber) async {
    _chapterName = chapterName;
    _shlokNumber = shlokNumber;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastReadChapter', chapterName);
    await prefs.setString('lastReadShlok', shlokNumber);
  }

  // Load progress from SharedPreferences
  Future<void> loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _chapterName = prefs.getString('lastReadChapter') ?? '';
    _shlokNumber = prefs.getString('lastReadShlok') ?? "";
    notifyListeners();
  }
}
