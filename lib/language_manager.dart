import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageManager extends ChangeNotifier {
  static const String _languageKey = 'isEnglish';
  bool _isEnglish = true;

  bool get isEnglish => _isEnglish;

  LanguageManager() {
    _loadLanguagePreference();
  }

  void switchLanguage() {
    _isEnglish = !_isEnglish;
    _saveLanguagePreference();
    notifyListeners();
  }

  void setLanguage(bool isEnglish) {
    _isEnglish = isEnglish;
    _saveLanguagePreference();
    notifyListeners();
  }

  Future<void> _saveLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_languageKey, _isEnglish);
  }

  Future<void> _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isEnglish = prefs.getBool(_languageKey) ?? true;
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
