import 'package:flutter/material.dart';

final lightTheme = ThemeData(
   primaryColor: const Color.fromARGB(255, 158, 53, 177).withAlpha(10),
        cardColor: Colors.white,
        canvasColor: Colors.white,
        dividerColor: Colors.blueAccent,
        errorColor: Colors.grey.withOpacity(0.4),
        backgroundColor: Colors.transparent,
        hoverColor: Colors.grey.withOpacity(0.2),
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        secondaryHeaderColor: Colors.black,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
          shadowColor: Color.fromRGBO(0,27,59,1),
          color: Colors.white,
            elevation: 2,
        ),
          textTheme: TextTheme(
          labelLarge: TextStyle(
            fontSize: 24,
            color: Colors.black87
          ),
          labelMedium: TextStyle(
            fontSize: 18,
            color: Colors.black87
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            color: Colors.black87
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w500
          ),
          displayLarge: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w600
          ),
        )
);
final darkTheme = ThemeData(
        primaryColor: const Color.fromARGB(255, 158, 53, 177).withAlpha(10),
        errorColor: Color.fromRGBO(0, 27, 59, 1),
        hoverColor: Color.fromRGBO(0, 27, 59, 1),
        canvasColor: Color.fromRGBO(0, 13, 29, 1),
        cardColor: Color.fromRGBO(0, 27, 59, 1), 
        dividerColor: Color.fromRGBO(0, 27, 59, 1),
        backgroundColor: Color.fromRGBO(0, 27, 59, 1),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        secondaryHeaderColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(0,27,59,1),
          surfaceTintColor: Color.fromRGBO(0, 13, 29, 1),
          elevation: 2,
        ),
        textTheme: TextTheme(
          labelLarge: TextStyle(
            fontSize: 24,
            color: Colors.white
          ),
          labelMedium: TextStyle(
            fontSize: 18,
            color: Colors.white
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            color: Colors.white
          ),
          displaySmall: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500
          ),
          displayLarge: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w600
          ),
        )
);