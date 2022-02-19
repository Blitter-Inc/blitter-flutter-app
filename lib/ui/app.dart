import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/config.dart';
import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/data/repositories.dart';
import './ui.dart';

class BlitterApp extends StatelessWidget {
  const BlitterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    // uncomment the following lines to clear storage
    // final billBloc = context.read<BillBloc>();
    // final configBloc = context.read<ConfigBloc>();
    // final contactBloc = context.read<ContactBloc>();
    // authBloc.clear();
    // billBloc.clear();
    // configBloc.clear();
    // contactBloc.clear();

    final isLoggedIn = authBloc.state.user != null;

    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        final lightThemeData = generateThemeDataFromPalette(
          themeData: ThemeData.light(),
          colorScheme: const ColorScheme.light(),
          palette: LightThemeColorPalette(),
          primary: state.primaryColor,
        );
        final darkThemeData = generateThemeDataFromPalette(
          themeData: ThemeData.dark(),
          colorScheme: const ColorScheme.dark(),
          palette: DarkThemeColorPalette(),
          primary: state.primaryColor,
        );
        return MaterialApp(
          title: 'Blitter',
          theme: lightThemeData,
          darkTheme: darkThemeData,
          themeMode: state.darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
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
              return BlocProvider<BillManagerCubit>(
                create: (_) => BillManagerCubit(
                  apiRepository: context.read<APIRepository>(),
                  apiSerializerRepository:
                      context.read<APISerializerRepository>(),
                  billBloc: context.read<BillBloc>(),
                ),
                child: BlocBuilder<ConfigBloc, ConfigState>(
                  builder: (context, state) {
                    final themeData = Theme.of(ctx);
                    return Theme(
                      data: generateModuleThemeData(
                        defaultThemeData: themeData,
                        modulePrimaryColor: state.billPrimaryColor,
                      ),
                      child: const BillManagerScreen(),
                    );
                  },
                ),
              );
            },
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
