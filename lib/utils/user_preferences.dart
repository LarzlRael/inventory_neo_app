part of 'utils.dart';

class UserPreferences {
  //no one this properties it is used
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDarkModeEnabled => _prefs.getBool('isDarkTheme') ?? false;

  static set isDarkTheme(bool value) {
    _prefs.setBool('isDarkTheme', value);
  }

  String get loginEmail {
    return _prefs.getString('loginEmail') ?? '';
  }

  set loginEmail(String value) {
    _prefs.setString('loginEmail', value);
  }

  int get currentIdHomework {
    return _prefs.getInt('currentIdHomework') ?? 0;
  }

  set currentIdHomework(int value) {
    _prefs.setInt('currentIdHomework', value);
  }

  bool get showInitialSlider {
    return _prefs.getBool('showInitialSlider') ?? true;
  }

  set setShowInitialSlider(bool value) {
    _prefs.setBool('showInitialSlider', value);
  }

  List<String> get getSubjectsList {
    return _prefs.getStringList('subjectsList') ?? [];
  }

  set setSubjectsList(List<String> listSubjects) {
    _prefs.setStringList('subjectsList', listSubjects);
  }

  int get getThemeStatus {
    return _prefs.getInt('themeStatus') ?? 0;
  }

  set setThemeStatus(int themeStatus) {
    _prefs.setInt('themeStatus', themeStatus);
  }
}
