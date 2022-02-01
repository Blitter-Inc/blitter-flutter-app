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
    required this.refreshListHandler,
  }) : super(key: key);

  final Function(BuildContext) showFilterModalHandler;
  final Function(BuildContext) showBillModalHandler;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final VoidCallback refreshListHandler;

  @override
  State<BillManagerAppBar> createState() => _BillManagerAppBarState();
}

class _BillManagerAppBarState extends State<BillManagerAppBar> {
  bool _searchBarEnabled = false;
  late BillManagerCubit cubit;
  late TextEditingController _searchController;
  late Debouncer _deboucer;

  _toggleSearchBar() {
    setState(() {
      _searchBarEnabled = !_searchBarEnabled;
    });
  }

  void _enableSearch(String search) {
    cubit.enableSearchFilter(search);
    widget.refreshListHandler();
  }

  void _clearSearch() {
    _searchController.clear();
    cubit.disableSearchFilter();
    widget.refreshListHandler();
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _deboucer = Debouncer(
      duration: const Duration(milliseconds: 600),
    );
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
      controller: _searchController,
      onChanged: (search) => _deboucer.run(() {
        if (_searchController.text.length > 2) {
          _enableSearch(search);
        } else if (_searchController.text.isEmpty) {
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
        child: _searchBarEnabled ? searchBar : appBarTitle,
      ),
      actions: [
        if (!(Platform.isAndroid || Platform.isIOS) && !_searchBarEnabled)
          IconButton(
            onPressed: () => widget.refreshIndicatorKey.currentState!.show(),
            icon: const Icon(Icons.refresh),
          ),
        IconButton(
          onPressed: () {
            if (_searchBarEnabled) _clearSearch();
            _toggleSearchBar();
          },
          icon: Icon(_searchBarEnabled ? Icons.clear : Icons.search),
        ),
      ],
    );
  }
}
