import 'package:stamp_app/Constants/setting.dart';

enum CheckString { ok }

extension CheckStringExtension on CheckString {
  static final checkStringValues = {CheckString.ok: Setting.VALID_TEXT};
  String? get checkStringValue => checkStringValues[this];
}
