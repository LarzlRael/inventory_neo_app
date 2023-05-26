part of 'utils.dart';

class UserPreferences {
  //no one this properties it is used
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDarkModeEnabled => _prefs.getBool('isDarkTheme') ?? false;

  int get getThemeStatus {
    return _prefs.getInt('themeStatus') ?? 0;
  }

  set setThemeStatus(int themeStatus) {
    _prefs.setInt('themeStatus', themeStatus);
  }
}
