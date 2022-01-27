import 'package:flutter_bloc/flutter_bloc.dart';

import './bill_manager_state.dart';

class BillManagerCubit extends Cubit<BillManagerState> {
  BillManagerCubit() : super(BillManagerState.init());

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
}
