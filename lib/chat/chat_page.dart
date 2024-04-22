import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/Model/UserModel/abstract_user_model.dart';
import 'package:flutterchatapp/Model/UserModel/user_model.dart';
import 'package:flutterchatapp/Model/message_model.dart';
import 'package:flutterchatapp/main.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState(this.room_id, this.other_user);
  late int room_id;
  late UserModel other_user;

  ChatPage(int room_id, UserModel other_user){
    this.room_id = room_id;
    this.other_user = other_user;
  }
}
class _ChatPageState extends State<ChatPage> {
  late WebSocketChannel _channel;
   late int room_id;
  late UserModel other_user;

  _ChatPageState(int room_id, UserModel other_user){
    this.room_id = room_id;
    this.other_user = other_user;
    this._channel = WebSocketChannel.connect(
      Uri.parse('ws://$ip/chats/${room_id}/${other_user.id}')
    );
    }
  List<MessageModel> messages = [];

    @override
    void initState() {
      super.initState();
      _initAllMessages();
      print(messages.toString());
      print(room_id);
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(other_user.name!,
        style: Theme.of(context).textTheme.displayLarge,),
      ),
      body: Container(
      child: Column(
        children: [
          Expanded(child: Column(
            children: [
              Text(room_id.toString()),
              Text(ip),
              Text(this.messages.toString())

            ],
          )),
          Container(
            padding: EdgeInsets.all(25),
            child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(100),
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                          },
                          icon: Icon(Icons.send),
                        ),
                      ),
                    ),
            ),
        ],
      ),
      ),
    );
  }  Future<void> _initAllMessages() async{
    messages.clear();

    var response = await Dio().get(
      'http://$ip/chats/$room_id'
    );

    List<dynamic> data = (response.data as Map<String, dynamic>)['data'];

    data.forEach((msg) {
      if(msg['message'].toString().length > 0) {
        messages.add (
            MessageModel(user_id: msg['user_id'], message: msg['message'])
        );
      }
    });
  }
  @override
  void dispose() {
    _channel.sink.close();

    super.dispose();
  }
}
