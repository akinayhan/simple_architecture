import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.blueAccent
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
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
      labelColor: Colors.white
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black12,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
        color: Colors.white,
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
      backgroundColor: WidgetStateProperty.all<Color>(Colors.blueAccent.withOpacity(0.8)),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    ),
  ),
);