import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'firebase_options.dart';

import './data/blocs.dart';
import './data/repositories.dart';
import './ui/app.dart';

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
      BlocProvider<AuthBloc>(
        create: (_) => AuthBloc(),
        lazy: false,
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<APIRepository>(
              create: (context) => APIRepository(
                authState: context.read<AuthBloc>().state,
              ),
            ),
            RepositoryProvider<APISerializerRepository>(
              create: (_) => APISerializerRepository(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<ConfigBloc>(
                create: (_) => ConfigBloc(),
                lazy: false,
              ),
              BlocProvider<AuthBloc>(
                create: (_) => AuthBloc(),
                lazy: false,
              ),
              BlocProvider<BillBloc>(
                create: (_) => BillBloc(),
                lazy: false,
              ),
              BlocProvider<ContactBloc>(
                create: (_) => ContactBloc(),
                lazy: false,
              ),
            ],
            child: const BlitterApp(),
          ),
        ),
      ),
    ),
    storage: await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory(),
    ),
  );
}
