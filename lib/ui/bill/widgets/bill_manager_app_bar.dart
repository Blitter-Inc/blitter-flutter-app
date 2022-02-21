import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/utils/debouncer.dart';

class BillManagerAppBar extends StatefulWidget {
  const BillManagerAppBar({
    Key? key,
    required this.showFilterModalHandler,
    required this.showBillModalHandler,
    required this.refreshIndicatorKey,
  }) : super(key: key);

  final Function(BuildContext) showFilterModalHandler;
  final Function(BuildContext) showBillModalHandler;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  @override
  State<BillManagerAppBar> createState() => _BillManagerAppBarState();
}

class _BillManagerAppBarState extends State<BillManagerAppBar> {
  late BillManagerCubit cubit;
  final Debouncer _deboucer = Debouncer(
    duration: const Duration(milliseconds: 600),
  );
  String _lastSearched = "";

  void _clearSearch() {
    cubit.disableSearchFilter();
    _lastSearched = "";
  }

  @override
  Widget build(BuildContext context) {
    cubit = context.read<BillManagerCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    final appBarTitle = Row(
      children: const [
        Text(
          'Bill Manager',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    final searchBar = TextField(
      autofocus: true,
      controller: cubit.state.searchController,
      onChanged: (search) => _deboucer.run(() {
        if (search.length > 2 && search != _lastSearched) {
          cubit.enableSearchFilter();
          _lastSearched = search;
        } else if (search.isEmpty) {
          _clearSearch();
        }
      }),
      style: TextStyle(
        color: colorScheme.primary,
      ),
      decoration: const InputDecoration(
        hintText: 'Search',
        border: InputBorder.none,
      ),
      textCapitalization: TextCapitalization.sentences,
    );

    var actionBar = PreferredSize(
      preferredSize: const Size(double.infinity, 60),
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        child: Row(
          children: [
            OutlinedButton.icon(
              onPressed: () => widget.showFilterModalHandler(context),
              icon: const Icon(Icons.filter_alt, size: 16),
              label: const Text('Filter'),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                side: BorderSide(
                  color: colorScheme.primary,
                  width: 1.2,
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => widget.showBillModalHandler(context),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Bill'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return BlocBuilder<BillManagerCubit, BillManagerState>(
      buildWhen: (previous, current) =>
          previous.searchBarEnabled != current.searchBarEnabled,
      builder: (context, state) {
        return SliverAppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          floating: true,
          pinned: true,
          snap: true,
          stretch: true,
          elevation: 1,
          bottom: actionBar,
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            switchInCurve: Curves.easeOutQuint,
            child: state.searchBarEnabled ? searchBar : appBarTitle,
          ),
          actions: [
            if (!(Platform.isAndroid || Platform.isIOS) &&
                !state.searchBarEnabled)
              IconButton(
                onPressed: () =>
                    widget.refreshIndicatorKey.currentState!.show(),
                icon: const Icon(Icons.refresh),
              ),
            IconButton(
              onPressed: () {
                if (state.searchBarEnabled) {
                  _clearSearch();
                } else {
                  cubit.enableSearchBar();
                }
              },
              icon: Icon(state.searchBarEnabled ? Icons.clear : Icons.search),
            ),
          ],
        );
      },
    );
  }
}
