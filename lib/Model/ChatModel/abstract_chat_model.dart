import 'package:flutterchatapp/Model/message_model.dart';

abstract class AbstractChatModel{
    List<MessageModel> messages = [];
      List users = [];

      
      Future<void> initializeUsers();
}