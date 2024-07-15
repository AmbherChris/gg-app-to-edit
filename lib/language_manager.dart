import 'package:flutter/material.dart';

class LanguageManager extends ChangeNotifier {
  bool _isEnglish = true;

  bool get isEnglish => _isEnglish;

  void switchLanguage() {
    _isEnglish = !_isEnglish;
    notifyListeners();
  }

  void setLanguage(bool isEnglish) {
    _isEnglish = isEnglish;
    notifyListeners();
  }

  String get welcomeText =>
      _isEnglish ? 'Welcome to' : 'Maligayang pagdating sa';
  String get allPlants => _isEnglish ? 'All plants' : 'Lahat ng halaman';
  String get culinaryHerbs =>
      _isEnglish ? 'Culinary Herbs' : 'Mga Pangluto na Halaman';
  String get herbalTeas =>
      _isEnglish ? 'Herbal Teas' : 'Mga Tsaa ng Halamang-gamot';
  String get aromaticOils =>
      _isEnglish ? 'Aromatic Oils' : 'Mga Aromatic na Langis';
  String get searchHint => _isEnglish ? 'Search...' : 'Maghanap...';
}
