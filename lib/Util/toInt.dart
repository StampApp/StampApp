int parseBooleanToInt(bool deletedFlg) {
  var ret = 0;
  if (deletedFlg) {
    ret = 1;
  }
  return ret;
}

bool parseIntToBoolean(int deletedFlg) {
  var ret = false;
  if (deletedFlg == 1) {
    ret = true;
  }
  return ret;
}
