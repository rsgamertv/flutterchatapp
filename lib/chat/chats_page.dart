import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/Model/abstract_chat_model.dart';
import 'package:flutterchatapp/Model/chat_model.dart';
import 'package:flutterchatapp/Themes/style.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final usermodel = GetIt.I<AbstractChatModel>();
  @override
  void initState() {
    usermodel.initializeUsers();
    setState(() {
      usermodel.users;
    });
    super.initState(); 
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
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
            Expanded(child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15),
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
    ChatModel user = usermodel.users[id];

    return GestureDetector(
      onTap: (){  
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
              backgroundImage: AssetImage('assets/manimage.png'),
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
}