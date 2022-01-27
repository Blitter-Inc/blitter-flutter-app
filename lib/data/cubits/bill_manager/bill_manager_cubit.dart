import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/repositories.dart';
import './bill_manager_state.dart';

class BillManagerCubit extends Cubit<BillManagerState> {
  BillManagerCubit({
    required this.apiRepository,
    required this.apiSerializerRepository,
    required this.billBloc,
  }) : super(BillManagerState.init());

  final APIRepository apiRepository;
  final APISerializerRepository apiSerializerRepository;
  final BillBloc billBloc;

  void setOrderingFilter(String ordering) {
    emit(state.copyWith(
        filters: state.filters..update('ordering', (_) => ordering)));
  }

  void setStatusFilter(String status) {
    emit(state.copyWith(
        filters: state.filters..update('status', (_) => status)));
  }

  void clearStatusFilter() {
    emit(state.copyWith(filters: state.filters..update('status', (_) => '')));
  }

  void addTypeFilter(String type) {
    emit(state.copyWith(
        filters: state.filters..update('type', (value) => value..add(type))));
  }

  void removeTypeFilter(String type) {
    emit(state.copyWith(
        filters: state.filters
          ..update('type', (value) => value..remove(type))));
  }

  void enableFilters() {
    emit(state.copyWith(
      filtersEnabled: true,
      lastBuildTimestamp: DateTime.now().microsecondsSinceEpoch,
    ));
  }

  void clearFilters() {
    emit(BillManagerState.init());
  }

  Future<void> refreshBillState() async {
    // TODO: will be replaced with a more efficient way to update state
    final response = await apiRepository.fetchBills();
    final event = InitializeBillState(
      apiSerializerRepository.fetchBillsResponseSerializer(
        jsonDecode(response.body),
      ),
    );
    billBloc.add(event);
  }
}
