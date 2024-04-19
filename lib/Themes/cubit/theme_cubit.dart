import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/repository/Settings/settings_interface.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required this.repository}) : super(ThemeState(repository.isDarkTheme() ? Brightness.dark : Brightness.light));
  final SettingsRepository repository;
  Future<void> SetThemeBrightness(Brightness brightness) async{
    emit(ThemeState(brightness));
    await repository.isDarkThemeSet(brightness == Brightness.dark);

  }
}
