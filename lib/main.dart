import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimalsocialtute/auth/login_or_register.dart';
import 'package:minimalsocialtute/firebase_options.dart';
import 'package:minimalsocialtute/theme/dark_mode.dart';
import 'package:minimalsocialtute/theme/light_mode.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions())
    runApp(const MyApp());
}

class MyApp extends StatelessWidget{
    const MyApp({super.key});

    @override
    Widget build(BuildContext context){
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const AuthPage(),
            theme: lightMode,
            darkTheme: darkMode,
            routes: {
                'login_register_page':(context) => const LoginOrRegister(),
                'home_page':(context) => HomePage(),
                'profile_page':(context) => const ProfilePage(),
                'users_page':(context) => const UsersPage(),
            },
        ); // MaterialApp
    }
}
