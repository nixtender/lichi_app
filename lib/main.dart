import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/data/services/database.dart';
import 'package:lichi_app/router/router.dart';
import 'package:lichi_app/ui/bloc/basket/basket_bloc.dart';
import 'package:lichi_app/ui/bloc/basket/basket_state.dart';
import 'package:lichi_app/ui/bloc/catalog/catalog_bloc.dart';
import 'package:lichi_app/ui/bloc/catalog/catalog_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();
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
    return MultiBlocProvider(
        providers: [
          BlocProvider<CatalogBloc>(
            create: (context) => CatalogBloc(CatalogEmptyState()),
          ),
          BlocProvider<BasketBloc>(
            create: (context) => BasketBloc(BasketEmptyState()),
          ),
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          routerConfig: _appRouter.config(),
          theme: ThemeData(
              //primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  titleTextStyle: TextStyle(color: Colors.black)),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFF6F6F6),
                      foregroundColor: Colors.black))),
          darkTheme: ThemeData.dark(),
          themeMode: _themeMode,
          // home: CatalogPage(),
        ));
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
