import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/Model/ChatModel/abstract_chat_model.dart';
import 'package:flutterchatapp/Model/UserModel/abstract_user_model.dart';
import 'package:flutterchatapp/Model/UserModel/user_model.dart';
import 'package:flutterchatapp/Themes/style.dart';
import 'package:flutterchatapp/chat/chat_page.dart';
import 'package:flutterchatapp/main.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatsPage> {
  final usermodel = GetIt.I<AbstractChatModel>();
  @override
  void initState() {
    super.initState(); 
    usersinit();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Чаты',style: theme.textTheme.labelMedium,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: theme.errorColor,
              child: TextFormField(
                decoration: searchFieldDecoration('Найти человека'),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15),
                itemCount: 6,
               itemBuilder: userListBuilder))
          ],
        ),
      ),
    );
  }
  Widget userListBuilder(BuildContext context, int id){
      if(id >= usermodel.users.length){
      return Container();
    }
    UserModel user = usermodel.users[id];

    return GestureDetector(
      onTap: (){ 
        goToChat(user); 
        },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                width: 2,
                color: Colors.grey.withOpacity(0.5)
            )
        ),
        child: Row(
          children: [
            Expanded(child: Container(),flex: 5,),
            Expanded(child: CircleAvatar(
              radius: 35,
            ),flex: 20,),
            Expanded(child: Container(),flex: 3,),
            Expanded(child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container(),flex: 10,),
                  Expanded(child: Text(user.name!, style: Theme.of(context).textTheme.displayLarge,),flex: 20,),
                  Expanded(child: Container(),flex: 2,),
                  Expanded(child: Text(user.email!, style: Theme.of(context).textTheme.displayMedium,),flex: 15,),
                  Expanded(child: Container(),flex: 10,)
                ],
              ),
            ),flex: 60,),
            Expanded(child: Container(),flex: 3,),
            Expanded(child: Icon(Icons.one_k),flex: 10,),
            Expanded(child: Container(),flex: 5,)
          ],
        ),
      )
    );
  }
  void usersinit () async{
    await usermodel.initializeUsers();
    setState(() {
      usermodel.users;
    });
  }
    void goToChat(UserModel otherUser) async{
    var json = {
      'data': [
      GetIt.I<AbstractUserModel>().id ,
      otherUser.id
      ]
    };

    final response = await Dio().post(
      'http://${ip}/chats/', data: json
    );

    final data = response.data as Map<String, dynamic>;
    final room_id = data['data']['room_id'];

    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => ChatPage(room_id , otherUser))
    );
  }
}