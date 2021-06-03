bool checkIsMaxStamps(int successStampLen, int maxStamp) {
  //上限無しの場合0を指定
  if (maxStamp == 0) return false;
  if (successStampLen + 1 >= maxStamp) {
    return true;
  } else {
    return false;
  }
}
