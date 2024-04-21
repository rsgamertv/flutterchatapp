import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/Authorization/bloc/bloc/authorization_bloc.dart';
import 'package:flutterchatapp/Model/UserModel/abstract_user_model.dart';
import 'package:flutterchatapp/Model/UserModel/user_model.dart';
import 'package:flutterchatapp/Model/abstract_chat_model.dart';
import 'package:flutterchatapp/Model/chat_model.dart';
import 'package:flutterchatapp/Themes/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchatapp/Themes/cubit/theme_cubit.dart';
import 'package:flutterchatapp/repository/Settings/settings_interface.dart';
import 'package:flutterchatapp/routes.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

  String ip = '83.147.245.57:8080';
Future<void> main() async{
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    GetIt.I.registerLazySingleton<AbstractChatModel>(() => ChatModel(dio: Dio()));
    GetIt.I.registerLazySingleton<AbstractUserModel>(() => UserModel(dio: Dio()));
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
        BlocProvider(create: (context) => AuthorizationBloc())
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
            return Sizer(
              builder: (context, orientation, deviceType){
              return MaterialApp(
              theme: state.brightness == Brightness.light ? lightTheme : darkTheme,
              debugShowCheckedModeBanner: false,
              routes: routes,
              initialRoute: '/Authorization',
              );
              }
            );
        },
      ),
    );
  }
}
