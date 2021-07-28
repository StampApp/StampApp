int parseBooleanToInt(bool useFlg) {
  var ret = 0;
  if (useFlg) {
    ret = 1;
  }
  return ret;
}

bool parseIntToBoolean(int useFlg) {
  var ret = false;
  if (useFlg == 1) {
    ret = true;
  }
  return ret;
}
