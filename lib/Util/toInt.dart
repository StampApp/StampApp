int parseBooleanToInt(bool deletedFlg) {
  var ret = 0;
  if (!deletedFlg) {
    ret = 1;
  }
  return ret;
}
