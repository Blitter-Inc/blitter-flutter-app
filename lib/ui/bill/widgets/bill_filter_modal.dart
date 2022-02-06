import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/constants.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';
import './filter_modal_tile.dart';

class BillFilterModal extends StatelessWidget {
  const BillFilterModal({
    Key? key,
    required this.refreshList,
  }) : super(key: key);

  final VoidCallback refreshList;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final cubit = context.read<BillManagerCubit>();

    final modalWidth = mediaQuery.size.width - 100;

    return BlocBuilder<BillManagerCubit, BillManagerState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (!state.filtersEnabled) {
              cubit.clearFilters();
            }
            return true;
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 500),
              width: modalWidth,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                      bottom: 60,
                    ),
                    child: Column(
                      children: [
                        FilterModalTile(
                          label: 'Display Order',
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 5,
                            children: FetchAPIOrdering.values.map(
                              (e) {
                                final selected = e == state.orderingFilter;
                                return FilterChip(
                                  label: Text(
                                      FetchAPIOrdering.displayValueMap[e]!),
                                  selected: selected,
                                  onSelected: (_) {
                                    cubit.setOrderingFilter(e);
                                  },
                                  labelStyle: themeData.chipTheme.labelStyle!
                                      .copyWith(
                                          color: !selected
                                              ? themeData
                                                  .colorScheme.disabledChipText
                                              : null),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        const Divider(),
                        FilterModalTile(
                          label: 'Type of Bill',
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 5,
                            children: BillType.values.sublist(1).map((e) {
                              final selected = state.typeFilter.contains(e);
                              return FilterChip(
                                label: Text(BillType.displayValueMap[e]!),
                                selected: selected,
                                onSelected: (value) {
                                  if (value) {
                                    cubit.addTypeFilter(e);
                                  } else {
                                    cubit.removeTypeFilter(e);
                                  }
                                },
                                labelStyle: themeData.chipTheme.labelStyle!
                                    .copyWith(
                                        color: !selected
                                            ? themeData
                                                .colorScheme.disabledChipText
                                            : null),
                              );
                            }).toList(),
                          ),
                        ),
                        const Divider(),
                        FilterModalTile(
                          label: 'Status',
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 5,
                            children: BillStatus.values.map((e) {
                              final selected = e == state.statusFilter;
                              return FilterChip(
                                label: Text(BillStatus.displayValueMap[e]!),
                                selected: selected,
                                onSelected: (value) {
                                  if (value) {
                                    cubit.setStatusFilter(e);
                                  } else {
                                    cubit.clearStatusFilter();
                                  }
                                },
                                labelStyle: themeData.chipTheme.labelStyle!
                                    .copyWith(
                                        color: !selected
                                            ? themeData
                                                .colorScheme.disabledChipText
                                            : null),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 50,
                      width: modalWidth,
                      color: themeData.colorScheme.modalBackground,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              child: const Text('Clear'),
                              onPressed: () {
                                cubit.clearFilters();
                                refreshList();
                                Navigator.of(context).pop();
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                side: BorderSide(
                                  color: themeData.colorScheme.primary,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              child: const Text('Apply'),
                              onPressed: () async {
                                cubit.enableFilters();
                                refreshList();
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
