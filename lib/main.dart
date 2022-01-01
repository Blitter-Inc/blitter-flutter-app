import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './modules/auth/screens/signin_screen.dart';
import './modules/home/screens/dashboard_screen.dart';

void main() {
  runApp(const BlitterApp());
}

class BlitterApp extends StatelessWidget {
  const BlitterApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return MaterialApp(
      title: 'Blitter',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.lightGreen,
        colorScheme: const ColorScheme.dark(
          primary: Colors.lightGreen,
          primaryVariant: Colors.teal,
        ),
      ),
      themeMode: ThemeMode.dark,
      initialRoute: SigninScreen.route,
      routes: {
        SigninScreen.route: (_) => const SigninScreen(),
        DashboardScreen.route: (_) => const DashboardScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
