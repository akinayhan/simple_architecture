import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  bool _isDarkTheme;

  ThemeNotifier(this._isDarkTheme);

  bool get isDarkTheme => _isDarkTheme;

  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    await _saveThemePreference(_isDarkTheme);
    notifyListeners();
  }

  Future<void> _saveThemePreference(bool isDarkTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDarkTheme);
  }
}

class ThemeWrapper extends StatefulWidget {
  final ThemeNotifier themeNotifier;
  final Widget child;

  const ThemeWrapper({Key? key, required this.themeNotifier, required this.child})
      : super(key: key);

  static _ThemeWrapperState of(BuildContext context) {
    return context.findAncestorStateOfType<_ThemeWrapperState>()!;
  }

  @override
  _ThemeWrapperState createState() => _ThemeWrapperState();
}

class _ThemeWrapperState extends State<ThemeWrapper> {
  late ThemeNotifier themeNotifier;

  @override
  void initState() {
    super.initState();
    themeNotifier = widget.themeNotifier;
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    themeNotifier = ThemeNotifier(isDarkTheme);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>.value(
      value: themeNotifier,
      child: widget.child,
    );
  }
}