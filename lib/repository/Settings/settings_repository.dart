abstract interface class SettingsRepoInterface{
  bool isDarkTheme();

  Future<void> isDarkThemeSet(bool selected);
}