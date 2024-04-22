    import 'package:dio/dio.dart';
import 'package:flutterchatapp/Model/ChatModel/abstract_chat_model.dart';
import 'package:flutterchatapp/Model/UserModel/abstract_user_model.dart';
import 'package:flutterchatapp/Model/UserModel/user_model.dart';
import 'package:flutterchatapp/main.dart';
import 'package:get_it/get_it.dart';

class  ChatModel  extends AbstractChatModel{
  Future<void> initializeUsers() async {
    final response = await Dio().get(
      'http://$ip/users/all'
    );
    final data = response.data as Map<String, dynamic>;

    final userslist = data['data'] as List<dynamic>;

    userslist.forEach((user) {
      UserModel userToAdd = UserModel(dio: Dio());
      userToAdd.id = user['id'];
      userToAdd.email = user['email'];
      userToAdd.name = user['name'];

      if(userToAdd.id != GetIt.I<AbstractUserModel>().id){
        users.add(userToAdd);
      }
    });

  }
}