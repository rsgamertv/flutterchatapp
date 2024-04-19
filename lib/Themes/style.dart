import 'package:flutter/material.dart';

InputDecoration searchFieldDecoration(String hint){
    return InputDecoration(
      fillColor: Colors.transparent,
      focusColor: Colors.transparent,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      filled: true,
      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
    
      hintText: hint,
      suffixIcon: Icon(
        Icons.search,
        color: Colors.grey.withOpacity(0.8),
      )
    );
}