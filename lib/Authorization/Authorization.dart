import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchatapp/Authorization/bloc/bloc/authorization_bloc.dart';
import 'package:flutterchatapp/Model/UserModel/abstract_user_model.dart';
import 'package:flutterchatapp/Style.dart';
import 'package:flutterchatapp/Themes/text_styles.dart';
import 'package:flutterchatapp/helpers.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authorization extends StatefulWidget {
  @override
  State<Authorization> createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  bool passwordVisible = false;
  bool isChecked = false;

  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  void updatePasswordType(bool passwordVisible) => setState(() {
      this.passwordVisible = passwordVisible;
  });

  @override
  void initState() {
    super.initState();
    isChecked = false;
  }

  setRememberPassword(bool value){
    setState(() {
      isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context){
    final bloccommand = BlocProvider.of<AuthorizationBloc>(context);
    return BlocListener<AuthorizationBloc, AuthorizationState>(
      listener: (BuildContext context, AuthorizationState state) { 
        if(emailController.text.toString().length > 0 && emailController.text.toString() != null && passwordController.text.toString() != 0 && passwordController.text.toString().length > 0){
          if(state is AuthorizationLoading){
            showLoadingCircle(context);
          }
          else if(state is AuthorizationLoaded){
            Navigator.of(context).pushNamed('/ChatPage');
            showSnackBar(context, 'Вы успешно вошли');
          }
          else if(state is AuthorizationFailure){
            Navigator.of(context).pop();
            showSnackBar(context, 'Не удалось зайти');
          }
        }
        else{
          showSnackBar(context, 'Введите логин и пароль');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(25, 170, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  'Fill in your email and password to continue',
                  style: small_grey(),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                Text('Email Adress', style: small_grey()),
                Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                TextField(
                  decoration: field_decoration('***********@mail.com'),
                  controller: emailController,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 25, 0, 0)),
                Text('Password', style: small_grey()),
                Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                TextField(
                  decoration: password_field_decoration(
                      '***********', passwordVisible, updatePasswordType),
                  obscureText: passwordVisible,
                  controller: passwordController,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: filledboxdecoration(),
                      child: TextButton(
                        onPressed: () {
                          GetIt.I<AbstractUserModel>().email =
                              emailController.text.toString();
                          GetIt.I<AbstractUserModel>().password =
                              passwordController.text.toString();
                          bloccommand.add(AuthorizationEvent());
                        },
                        child: Text('Log in', style: button_white()),
                      ),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
              ]
            )
        ),
      ),
    )
    );
  }
}
