class BillModalState {
  final bool isNewBill;

  BillModalState({required this.isNewBill});

  BillModalState copyWith({
    bool? isNewBill,
  }) =>
      BillModalState(isNewBill: isNewBill ?? this.isNewBill);
}
