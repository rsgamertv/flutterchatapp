import 'package:flutterchatapp/repository/Settings/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository implements SettingsRepoInterface{
  final SharedPreferences preferences;

  SettingsRepository({required this.preferences});
  static const IsDarkThemeKey = 'IsDarkThemeKey';
  @override
  bool isDarkTheme() {
    final selected = preferences.getBool(IsDarkThemeKey);
    return selected ?? false;
  }
  
  @override
  Future<void> isDarkThemeSet(bool selected) async{
    preferences.setBool(IsDarkThemeKey, selected);
  }

}