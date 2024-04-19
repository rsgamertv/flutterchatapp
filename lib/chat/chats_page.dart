import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/Themes/style.dart';
import 'package:sizer/sizer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
            // Expanded(child: GridView.builder(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 1,
            //     childAspectRatio: 3.5,
            //     crossAxisSpacing: 10,
            //     mainAxisSpacing: 15),
            //    itemBuilder: ))
          ],
        ),
      ),
    );
  }
  // Widget userListBuilder(BuildContext context, int id){

  // }
}