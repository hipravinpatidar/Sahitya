import 'package:flutter/material.dart';
import '../ui_helpers/custom_colors.dart';

class SettingsProvider with ChangeNotifier {

  // Define your settings variables here
  String _selectedFont = '';
  String _selectedLang = 'Hindi';
  final String _selectedType = '';
  final String _displayedText = '';

  bool _isOn = false;
  bool _showHindiText = true;
  bool _showEnglishText = true;
  final bool _showBookFormate = false;


  Color _textColor = CustomColors.clrwhite;
  double _fontSize = 16.0;


  // Define your update functions here
  void updateFont(String value) {
    _selectedFont = value;
    notifyListeners();
  }

  void changeTextColor(Color color) {
    _textColor = color;
    notifyListeners();
  }

  void updateFontSize(double fontSize) {
    _fontSize = fontSize;
    notifyListeners();
  }

  void onClickIt() {
    _isOn = !_isOn;
    notifyListeners();
  }

  void updateLang(String value) {
    _selectedLang = value;
    print(" My Selected Language Is $_selectedLang");
    notifyListeners();
  }

  updateHindiText() {
    _showHindiText = !_showHindiText;
    notifyListeners();
  }

  updateEnglishText() {
    _showEnglishText = !_showEnglishText;
    notifyListeners();
  }

  // Getters for your settings variables
  String get selectedFont => _selectedFont;
  double get fontSize => _fontSize;
  bool get isOn => _isOn;
  String get selectedLang => _selectedLang;
  bool get showHindiText => _showHindiText;
  bool get showEnglishText => _showEnglishText;
  bool get showBookFormate => _showBookFormate;
  String get selectedType => _selectedType;
  String get displayedText => _displayedText;
  Color get textColor => _textColor;
}

