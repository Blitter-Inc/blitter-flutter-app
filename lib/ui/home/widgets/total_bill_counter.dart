import 'package:flutter/material.dart';

import 'package:blitter_flutter_app/data/models.dart';
import 'package:blitter_flutter_app/ui.dart';
import 'package:blitter_flutter_app/ui/shared.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';

class TotalBillCounter extends StatelessWidget {
  const TotalBillCounter({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot<DashboardCounters> snapshot;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final isLoading = !snapshot.hasData;
    final data = snapshot.data;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          BillManagerScreen.route,
        );
      },
      child: SizedBox(
        height: 165,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Card(
              color: colorScheme.dashboardCardBackground,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              elevation: 10,
              shadowColor: colorScheme.primary,
              child: Container(
                height: 120,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 30),
                child: isLoading
                    ? const Center(
                        child: LoadingSpinner(),
                      )
                    : Row(
                        children: [
                          Text(
                            '${data!.totalBillCount}',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          // const Spacer(),
                          const SizedBox(width: 20),
                          Text(
                            'Bills were linked to your account so far',
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Bill Manager > ',
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
