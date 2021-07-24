enum StampCount { count }

extension StampCountExtension on StampCount {
   static final stampCountValues = {StampCount.count: 9};

  int? get stampCount => stampCountValues[this];
}
