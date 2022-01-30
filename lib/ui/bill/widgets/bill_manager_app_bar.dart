import 'package:flutter/material.dart';

class BillManagerAppBar extends StatelessWidget {
  const BillManagerAppBar({
    Key? key,
    required this.refreshIndicatorKey,
    required this.showFilterModalHandler,
    required this.showBillModalHandler,
  }) : super(key: key);

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final Function(BuildContext) showFilterModalHandler;
  final Function(BuildContext) showBillModalHandler;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
      bottom: PreferredSize(
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
                onPressed: () => showFilterModalHandler(context),
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
                onPressed: () => showBillModalHandler(context),
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
      ),
      title: const Text(
        'Bill Manager',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => refreshIndicatorKey.currentState!.show(),
          icon: const Icon(Icons.refresh),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
