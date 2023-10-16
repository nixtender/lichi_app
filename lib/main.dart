import 'package:flutter/material.dart';
import 'package:lichi_app/router/router.dart';
import 'package:lichi_app/ui/roots/pages/catalog_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: _appRouter.config(),
      theme: ThemeData(
          //primarySwatch: Colors.blue,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFF6F6F6),
                  foregroundColor: Colors.black))),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      // home: CatalogPage(),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
