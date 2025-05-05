import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'utils/function/app_providers.dart';
import 'views/screens/login/sign_in_page.dart';
import 'views/screens/menu/menu/menu_page.dart';
import 'views/theme/dark_theme.dart';
import 'views/theme/light_theme.dart';
import 'views/theme/theme_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isDarkTheme = await _loadThemePreference();
  final themeNotifier = ThemeNotifier(isDarkTheme);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => themeNotifier,
        ),
        ...getAppProviders(),
      ],
      child: ThemeWrapper(
        themeNotifier: themeNotifier,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, _) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: const [
            Locale('en'),
            Locale('tr'),
          ],
          theme: themeNotifier.isDarkTheme ? darkTheme : lightTheme,
          home: const SignInPage(),
          routes: {
            '/signIn': (context) => const SignInPage(),
            '/menu': (context) =>  const MenuPage(),
          },
        );
      },
    );
  }
}

Future<bool> _loadThemePreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isDarkTheme') ?? false;
}