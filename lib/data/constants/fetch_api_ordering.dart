class FetchAPIOrdering {
  static const _lastUpdatedAtDesc = ['-updated_at', 'Updated at: Recent'];
  static const _lastUpdatedAtAsc = ['updated_at', 'Updated at: Oldest'];

  static final lastUpdatedAtDesc = _lastUpdatedAtDesc[0];
  static final lastUpdatedAtAsc = _lastUpdatedAtAsc[0];

  static final values = <String>[
    _lastUpdatedAtDesc[0],
    _lastUpdatedAtAsc[0],
  ];

  static final valueIndexMap = <String, int>{
    _lastUpdatedAtDesc[0]: 1,
    _lastUpdatedAtAsc[0]: 0,
  };

  static final displayValues = <String>[
    _lastUpdatedAtDesc[1],
    _lastUpdatedAtAsc[1],
  ];

  static final displayValueMap = <String, String>{
    _lastUpdatedAtDesc[0]: _lastUpdatedAtDesc[1],
    _lastUpdatedAtAsc[0]: _lastUpdatedAtAsc[1],
  };
}
