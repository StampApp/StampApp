import 'package:stamp_app/Constants/setting.dart';

enum StampCount { count }

extension StampCountExtension on StampCount {
  static final stampCountValues = {StampCount.count: Setting.MAX_STAMPS};
  int? get stampCount => stampCountValues[this];
}
