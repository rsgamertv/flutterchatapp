import 'package:flutter/material.dart';
import 'package:flutterchatapp/Themes/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchatapp/Themes/cubit/theme_cubit.dart';
import 'package:flutterchatapp/repository/Settings/settings_interface.dart';
import 'package:flutterchatapp/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async{
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    runApp(MyApp(
      preferences: prefs,
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.preferences});
  final SharedPreferences preferences;
  @override
  Widget build(BuildContext context) {
    final repo = SettingsRepository(preferences: this.preferences);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(repository: repo),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
          theme: state.brightness == Brightness.light ? lightTheme : darkTheme,
          debugShowCheckedModeBanner: false,
          routes: routes,
          initialRoute: '/ChatPage',
          );
        },
      ),
    );
  }
}
