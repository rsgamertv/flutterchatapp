import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutterchatapp/Model/UserModel/abstract_user_model.dart';
import 'package:flutterchatapp/main.dart';
import 'package:get_it/get_it.dart';

class UserModel extends AbstractUserModel{
  final Dio dio;

  UserModel({required this.dio});
  @override
  Future<bool> checkIfExists() async{
    AbstractUserModel userModel;
    try{
    final response = await dio.get(
      'http://${ip}/users?email=${this.email}&password=${this.password}'
    );
    
    if(response.statusCode == 200){
      final json = response.data as Map<String, dynamic>;

      this.id = json['data']['id'];
      this.email = json['data']['email'];
      this.password = json['data']['password'];
      this.name = json['data']['name'];

      return true;
    } return false;} on DioException catch (error){
      if(error.response != null){
        return false;
      }
      else{
        return false;
      }
    } catch (e){
      return false;
    }
  }

  @override
  Future<bool> register() async{
    final json = new Map<String,dynamic>();

    json['email'] = this.email!;
    json['password'] = this.password!;
    json['name'] = this.name!;
    json['age'] = 0;

    final response = await dio.post(
      'http://${ip}/users', data: json
    );

    final jsonResponse = response.data as Map<String,dynamic>;

    return true;}

}