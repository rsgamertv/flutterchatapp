import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterchatapp/Model/ChatModel/abstract_chat_model.dart';
import 'package:flutterchatapp/Model/ChatModel/chat_model.dart';
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
  final ChatModel model = ChatModel();
  final ScrollController controller = ScrollController();
  TextEditingController textcontroller = TextEditingController();
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
      initmessage();
       _channel.stream.listen((event) async{
    if(event.toString().length > 0){
        var data = event.toString();

        int user_id = int.parse(data.substring(0, data.indexOf(':')));
        String message =  data.substring(data.indexOf(':') + 2);

        messages.add(MessageModel(user_id: user_id, message: message));

        setState(() {
          messages;
        });

        await Future.delayed(Duration(milliseconds: 100));

        scrolldown();
      } 
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(other_user.name!,
        style: Theme.of(context).textTheme.displayLarge,),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Expanded(child: ListView.builder(
            controller: controller,
            itemBuilder: (context, id){
            final message = messages[id];
            return Row(
              mainAxisAlignment: (message.user_id == GetIt.I<AbstractUserModel>().id)  ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                messageWidget(message)
              ],
            );
          }, itemCount: messages.length,
          
          )),
          Container(
            padding: EdgeInsets.all(25),
            child: TextFormField(
                      controller: textcontroller,
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
                            sendMessage();
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
  } 
  Widget messageWidget(MessageModel message){
    final size = MediaQuery.sizeOf(context);
    final aligment = (message.user_id == GetIt.I<AbstractUserModel>().id) ? Alignment.centerLeft : Alignment.centerRight;
    final color = (message.user_id == GetIt.I<AbstractUserModel>().id) ? Colors.grey : Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(100);
    final name = (message.user_id != GetIt.I<AbstractUserModel>().id) ? GetIt.I<AbstractUserModel>().name : other_user.name;

    return GestureDetector(
      child: Container(
        child: Align(
          alignment: aligment,
          child: 
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5.0),
            color: color,
            child: Column(
              children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: size.width * 0.66),
                    decoration: BoxDecoration(
                    ),
                    child: Column(
                      children: [
                        Text(name!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600
                        ),
                        ),
                  Text(message.message, style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp
                ),),
                      ],
                    ),
                  ),
              ],
            )
        
          )
          ,
        ),
      ),
    );

  }
  void initmessage () async{
    await model.initAllMessages();
    setState(() {
      GetIt.I<AbstractChatModel>().messages;
    });
    await Future.delayed(Duration(milliseconds: 100));
    scrolldown();
  }
  void sendMessage() {
    if(textcontroller.text.isNotEmpty){
      setState(() {
        _channel.sink.add(textcontroller.text);
        textcontroller.text = '';
        scrolldown();
      });
    }
    else{
      print('сообщение не было отправлено');
    }
  }
  void scrolldown() {
     controller.animateTo(
        controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);

  }
  @override
  void dispose() {
    _channel.sink.close();

    super.dispose();
  }
}
