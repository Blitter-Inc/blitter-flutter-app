class BillStatus {
  static const _unsettled = ['unsettled', 'Unsettled'];
  static const _fulfilled = ['fulfilled', 'Fulfilled'];

  static final unsettled = _unsettled[0];
  static final fulfilled = _fulfilled[0];

  static final values = <String>[
    _unsettled[0],
    _fulfilled[0],
  ];

  static final valueIndexMap = <String, int>{
    _unsettled[0]: 0,
    _fulfilled[0]: 1,
  };

  static final displayValues = <String>[
    _unsettled[1],
    _fulfilled[1],
  ];

  static final displayValueMap = <String, String>{
    _unsettled[0]: _unsettled[1],
    _fulfilled[0]: _fulfilled[1],
  };
}
