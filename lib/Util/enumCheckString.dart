enum CheckString { ok }

extension CheckStringExtension on CheckString {
  static final CheckStringValues = {CheckString.ok: 'ok'};

  String get checkStringValue => CheckStringValues[this];
}
