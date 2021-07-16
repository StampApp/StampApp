enum CheckString { ok }

extension CheckStringExtension on CheckString {
  static final checkStringValues = {CheckString.ok: 'ok'};

  String get checkStringValue => checkStringValues[this];
}
