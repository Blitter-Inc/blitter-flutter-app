import 'package:blitter_flutter_app/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';
import './filter_modal_tile.dart';
import './bottom_modal_button.dart';

class BillFilterModal extends StatelessWidget {
  const BillFilterModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final cubit = context.read<BillManagerCubit>();

    return BlocBuilder<BillManagerCubit, BillManagerState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (!state.filtersEnabled) {
              cubit.clearFilters();
            }
            return true;
          },
          child: Container(
            constraints: const BoxConstraints(maxHeight: 500),
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 40,
                    bottom: 60,
                  ),
                  child: Column(
                    children: [
                      FilterModalTile(
                        label: 'Display Order',
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: FetchAPIOrdering.values.map(
                            (e) {
                              final selected = e == state.orderingFilter;
                              return FilterChip(
                                label:
                                    Text(FetchAPIOrdering.displayValueMap[e]!),
                                selected: selected,
                                onSelected: (_) {
                                  cubit.setOrderingFilter(e);
                                },
                                labelStyle: themeData.chipTheme.labelStyle
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
                          runSpacing: 10,
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
                              labelStyle: themeData.chipTheme.labelStyle
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
                          runSpacing: 10,
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
                              labelStyle: themeData.chipTheme.labelStyle
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
                    height: 50,
                    color: Theme.of(context)
                        .colorScheme
                        .bottomSheetModalBackground,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        BottomModalButton(
                          label: 'Apply',
                          onPressed: () async {
                            cubit.enableFilters();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: TextButton.icon(
                    onPressed: () {
                      cubit.clearFilters();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.clear_all, size: 12.5),
                    label: const Text(
                      'Clear',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
