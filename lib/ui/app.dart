import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/config.dart';
import 'package:blitter_flutter_app/data/blocs.dart';
import './ui.dart';

class BlitterApp extends StatelessWidget {
  const BlitterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    // uncomment the following lines to clear storage
    // final billBloc = context.read<BillBloc>();
    // authBloc.clear();
    // billBloc.clear();

    final isLoggedIn = authBloc.state.user != null;

    return MaterialApp(
      title: 'Blitter',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: ThemeMode.system,
      initialRoute: isLoggedIn ? DashboardScreen.route : SigninScreen.route,
      routes: {
        SigninScreen.route: (_) {
          return Theme(
            data: darkThemeData,
            child: const SigninScreen(),
          );
        },
        DashboardScreen.route: (_) => const DashboardScreen(),
        BillManagerScreen.route: (ctx) {
          final themeData = Theme.of(ctx);
          return Theme(
            data: themeData.copyWith(
              colorScheme: themeData.colorScheme
                  .copyWith(primary: BillContext(ctx).primaryColor),
            ),
            child: const BillManagerScreen(),
          );
        },
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
