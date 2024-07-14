import 'package:flutter/material.dart';

class LanguageManager extends ChangeNotifier {
  bool _isEnglish = true;

  bool get isEnglish => _isEnglish;

  void switchLanguage() {
    _isEnglish = !_isEnglish;
    notifyListeners();
  }
}
