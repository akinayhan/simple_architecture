import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color(0xFF07538B)
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black12,
  ),

  tabBarTheme: const TabBarTheme(
    labelStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold
    ),
    labelColor: Colors.black
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold
    ),
  ),

  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    fillColor: Colors.transparent,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.blue.withOpacity(0.8)),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    ),
  ),
);