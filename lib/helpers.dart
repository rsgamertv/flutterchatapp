import 'package:flutter/material.dart';

void showSnackBar(context, String message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 1),
      content: Text(message),
      backgroundColor: Colors.grey,
    ),
  );
}

void showLoadingCircle(context){
  showDialog(
    barrierDismissible: false,
    builder: (context){
      return Center(child: CircularProgressIndicator());
    },
    context: context,
  );
}