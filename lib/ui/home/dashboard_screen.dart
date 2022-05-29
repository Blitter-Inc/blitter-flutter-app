import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/data/repositories/api_repository.dart';
import 'package:blitter_flutter_app/ui.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';
import './widgets/widgets.dart';

class DashboardScreen extends StatelessWidget {
  static const route = '/dashboard';

  const DashboardScreen({Key? key}) : super(key: key);

  Future<DashboardCounters> _fetchCounters(
    APIRepository apiRepository,
  ) async {
    final apiRes = await apiRepository.fetchCounters();
    final apiResBody = jsonDecode(apiRes.body);
    return DashboardCounters.fromApiJson(apiResBody);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
    final apiRepository = context.read<APIRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Activity Dashboard',
          style: TextStyle(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            color: colorScheme.primary,
            icon: const Icon(Icons.refresh),
            onPressed: context.resetApp,
          ),
          IconButton(
            color: colorScheme.primary,
            icon: const Icon(Icons.color_lens),
            onPressed: context.showColorPickerSheet,
          ),
          IconButton(
            color: colorScheme.primary,
            icon: BlocBuilder<ConfigBloc, ConfigState>(
              buildWhen: (previous, current) =>
                  previous.darkModeEnabled != current.darkModeEnabled,
              builder: (_, state) => Icon(
                state.darkModeEnabled ? Icons.mode_night : Icons.wb_sunny,
              ),
            ),
            onPressed: () {
              context.switchThemeMode();
            },
          ),
        ],
      ),
      body: Container(
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 30,
        ),
        child: FutureBuilder<DashboardCounters>(
          future: _fetchCounters(apiRepository),
          builder: (context, snapshot) {
            return Column(
              children: [
                const SizedBox(height: 20),
                TotalBillCounter(snapshot: snapshot),
                const SizedBox(height: 35),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      TransactionListScreen.route,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TotalTransactionCounter(snapshot: snapshot),
                      const SizedBox(height: 40),
                      DebitTransactionRow(snapshot: snapshot),
                      const SizedBox(height: 40),
                      CreditTransactionRow(snapshot: snapshot),
                      const SizedBox(height: 25),
                      Text(
                        'Transaction History > ',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
