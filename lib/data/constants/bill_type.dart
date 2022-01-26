class BillType {
  static const _none = ['', '-----'];
  static const _entertainment = ['entertainment', 'Entertainment'];
  static const _food = ['food', 'Food'];
  static const _shopping = ['shopping', 'Shopping'];
  static const _outing = ['outing', 'Outing'];
  static const _miscelleneous = ['miscelleneous', 'Miscelleneous'];

  static final none = _none[0];
  static final entertainment = _entertainment[0];
  static final food = _food[0];
  static final shopping = _shopping[0];
  static final outing = _outing[0];
  static final miscelleneous = _miscelleneous[0];

  static final values = <String>[
    _none[0],
    _entertainment[0],
    _food[0],
    _shopping[0],
    _outing[0],
    _miscelleneous[0],
  ];

  static final valueIndexMap = <String, int>{
    _none[0]: 0,
    _entertainment[0]: 1,
    _food[0]: 2,
    _shopping[0]: 3,
    _outing[0]: 4,
    _miscelleneous[0]: 5,
  };

  static final displayValues = <String>[
    _none[1],
    _entertainment[1],
    _food[1],
    _shopping[1],
    _outing[1],
    _miscelleneous[1],
  ];
}
