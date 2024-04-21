import 'package:dio/dio.dart';
import 'package:flutterchatapp/Model/abstract_chat_model.dart';
import 'package:flutterchatapp/main.dart';
import 'package:get_it/get_it.dart';

class ChatModel extends AbstractChatModel{
final Dio dio;

  ChatModel({required this.dio});

  Future<void> initializeUsers() async {
    final response = await Dio().get(
      'http://$ip/users/'
    );
    final data = response.data as Map<String, dynamic>;
    final userslist = data['data'] as List<dynamic>;
    userslist.forEach((user) {
      ChatModel userToAdd = ChatModel(dio: Dio());
      userToAdd.id = user['id'];
      userToAdd.email = userToAdd.email;
      userToAdd.name = user['name'];
      if(userToAdd.id != GetIt.I<AbstractChatModel>().id){
        users.add(userToAdd);
      }
    });
  }

}