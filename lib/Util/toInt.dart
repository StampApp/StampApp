/// boolをintへ変更
///
/// boolがfalseの場合は0に変更する
/// boolがtrueの場合は1に変更する
///

int parseBooleanToInt(bool deletedFlg) {
  var ret = 0;
  if (deletedFlg) {
    ret = 1;
  }
  return ret;
}

/// intをboolへ変更
///
/// intが0の場合はfalseに変更する
/// intが1の場合はtrueに変更する
///

bool parseIntToBoolean(int deletedFlg) {
  var ret = false;
  if (deletedFlg == 1) {
    ret = true;
  }
  return ret;
}
