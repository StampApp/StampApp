int parseBooleanToInt(bool deletedFlg) {
  var ret = 0;
  if (!deletedFlg) {
    ret = 1;
  }
  return ret;
}

bool parseIntToBoolean(int deletedFlg) {
  var ret = true;
  if (deletedFlg != 0) {
    ret = false;
  }
  return ret;
}