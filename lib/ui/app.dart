import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import './ui.dart';

class BlitterApp extends StatelessWidget {
  const BlitterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    // uncomment the following lines to clear storage
    // authBloc.clear();

    final isLoggedIn = authBloc.state.user != null;

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
        snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(
            color: Colors.black,
          ),
          backgroundColor: Colors.lightGreen,
        ),
      ),
      themeMode: ThemeMode.dark,
      initialRoute: isLoggedIn ? DashboardScreen.route : SigninScreen.route,
      routes: {
        SigninScreen.route: (_) => const SigninScreen(),
        DashboardScreen.route: (_) => const DashboardScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
