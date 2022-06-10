import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/appcubit/appcubit.dart';
import 'package:untitled1/appcubit/appstates.dart';
import 'package:untitled1/home.dart';
import 'package:untitled1/shared/blocobse.dart';
import 'package:untitled1/shared/cashehelber.dart';
import 'package:untitled1/shared/components.dart';
import 'package:untitled1/start/strat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = MyBlocObserver(); 
  await casheHelber.init();
  var start = casheHelber.getDataShared(key: 'start') ?? false;
  dark = casheHelber.getDataShared(key: 'dark') ?? false;

  print(start);
  print(dark);

  runApp(MyApp(start: start));
}

class MyApp extends StatelessWidget {
  // MyApp({Key? key}) : super(key: key);
  bool start;
  MyApp({
    required this.start,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) {
              return homeCubit()..createData();
            },
          ),
        ],
        child: BlocConsumer<homeCubit, HomeStates>(
          builder: (BuildContext context, state) {
            return MaterialApp(
              // ignore: prefer_const_literals_to_create_immutables
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('ar', ''), // arabic, no country code
              ],
              debugShowCheckedModeBanner: false,
              home: start ? home() : startpage(),
              themeMode: dark ? ThemeMode.dark : ThemeMode.light,
              theme: lightthem,
              darkTheme: ThemeData.dark(),
              locale: Locale('ar', ''),
            );
          },
          listener: (BuildContext context, Object? state) {},
        ));
  }

  ThemeData lightthem = ThemeData(
    // fontFamily: 'Foush',
    fontFamily: 'siu',
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),

    primarySwatch: Colors.orange,
    backgroundColor: Colors.orange,
    // ignore: prefer_const_constructors
    textTheme: TextTheme(
      bodyText1: const TextStyle(fontSize: 20, color: Colors.white),
      headline1: TextStyle(fontSize: 15, color: Colors.white),
      overline: TextStyle(fontSize: 10, color: Colors.white),
    ),
    // ignore: prefer_const_constructors
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    // ignore: prefer_const_constructors
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.orange,
        // ignore: prefer_const_constructors
        titleTextStyle: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        elevation: 0.0,
        // ignore: deprecated_member_use
        backwardsCompatibility: false,
        // ignore: prefer_const_constructors
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        )),
    // ignore: prefer_const_constructors
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.orange,
      selectedIconTheme: IconThemeData(color: Colors.orange),
    ),
  );

  ThemeData darkmode = ThemeData(
    // fontFamily: 'Foush',
    fontFamily: 'siu',
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),

    primarySwatch: Colors.orange,
    backgroundColor: Colors.orange,
    // ignore: prefer_const_constructors
    textTheme: TextTheme(
      // ignore: prefer_const_constructors
      bodyText1: TextStyle(fontSize: 20, color: Colors.white),
      headline1: TextStyle(fontSize: 15, color: Colors.white),
      overline: TextStyle(fontSize: 10, color: Colors.white),
    ),
    // ignore: prefer_const_constructors
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    // ignore: prefer_const_constructors
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.orange,
        // ignore: prefer_const_constructors
        titleTextStyle: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        elevation: 0.0,
        // ignore: deprecated_member_use
        backwardsCompatibility: false,
        // ignore: prefer_const_constructors
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        )),
    // ignore: prefer_const_constructors
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.orange,
      // ignore: prefer_const_constructors
      selectedIconTheme: IconThemeData(color: Colors.orange),
    ),
  );
}
