import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/data/services/database.dart';
import 'package:lichi_app/router/router.dart';
import 'package:lichi_app/ui/bloc/basket/basket_bloc.dart';
import 'package:lichi_app/ui/bloc/basket/basket_state.dart';
import 'package:lichi_app/ui/bloc/catalog/catalog_bloc.dart';
import 'package:lichi_app/ui/bloc/catalog/catalog_state.dart';
import 'package:lichi_app/ui/bloc/product/product_bloc.dart';
import 'package:lichi_app/ui/bloc/product/product_state.dart';

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
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(ProductEmptyState()),
          ),
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          routerConfig: _appRouter.config(),
          theme: ThemeData(
              //primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.transparent,
                  titleTextStyle: TextStyle(color: Colors.black)),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFF0F0F0),
                      foregroundColor: Colors.black)),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white))),
          darkTheme: ThemeData.dark().copyWith(
              appBarTheme: AppBarTheme(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  titleTextStyle: TextStyle(color: Colors.white)),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF767676),
                      foregroundColor: Colors.white)),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black))),
          themeMode: _themeMode,
          // home: CatalogPage(),
        ));
  }

  ThemeMode get themeMode => _themeMode;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
