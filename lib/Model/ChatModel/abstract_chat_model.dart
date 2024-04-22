import 'dart:ffi';

import 'package:flutterchatapp/Model/message_model.dart';

abstract class AbstractChatModel{
    List<MessageModel> messages = [];
      List users = [];
      int room_id = 1;
      
      Future<void> initializeUsers();
      Future<void> initAllMessages();
}