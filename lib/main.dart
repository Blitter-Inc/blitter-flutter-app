import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'firebase_options.dart';

import './data/blocs/blocs.dart';
import './modules/auth/screens/signin_screen.dart';
import './modules/home/screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  HydratedBlocOverrides.runZoned(
    () => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(),
          ),
        ],
        child: const BlitterApp(),
      ),
    ),
    storage: await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory(),
    ),
  );
}

class BlitterApp extends StatelessWidget {
  const BlitterApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
