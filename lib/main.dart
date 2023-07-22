import 'package:bnotes/home/edit_notes.dart';
import 'package:bnotes/home/home_screen.dart';
import 'package:bnotes/providers/auth_provider.dart';
import 'package:bnotes/providers/edit_provider.dart';
import 'package:bnotes/register/login_screen.dart';
import 'package:bnotes/register/register_screen.dart';
import 'package:bnotes/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (BuildContext) => AuthProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xffDA0037,   <int, Color>{
          50: Color(0xffDA0037 ),//10%
          100: Color(0xffcc0131),//20%
          200: Color(0xffb6012c),//30%
          300: Color(0xffa10127),//40%
          400: Color(0xff8c0122),//50%
          500: Color(0xff70011b),//60%
          600: Color(0xff520114),//70%
          700: Color(0xff2f010c),//80%
          800: Color(0xff170907),//90%
          900: Color(0xff000000),//100%
        },
        ),
        primaryColor: const Color(0xffDA0037),
        scaffoldBackgroundColor: const Color(0xff171717),
          floatingActionButtonTheme:const FloatingActionButtonThemeData(
            backgroundColor: Color(0xffDA0037),
          ),
          useMaterial3: false,
        bottomAppBarTheme:const BottomAppBarTheme(
            color: Color(0xff444444)
        ),
      ),
      initialRoute: SplashScreen.routeName ,
      routes: {
        EditNote.routeName : (_) => EditNote(),
        HomeScreen.routeName : (_) => HomeScreen(),
        RegisterScreen.routeName : (_) => RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        SplashScreen.routeName:(_) => SplashScreen()
      },
    );
  }
}
