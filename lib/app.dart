import 'package:flutter/material.dart';

import './modules/auth/screens/signin_screen.dart';
import './modules/home/screens/dashboard_screen.dart';

class BlitterApp extends StatelessWidget {
  const BlitterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
