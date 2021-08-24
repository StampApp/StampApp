///スタンプの比較
///
///第一引数[successStampLen]+1 が第二引数[maxStamp] 以上の場合trueを返す
///
///```
///checkIsMaxStamps(2,3) -> ture
///```
bool checkIsMaxStamps(int successStampLen, int maxStamp) {
  //上限無しの場合0を指定
  if (maxStamp == 0) return false;
  if (successStampLen + 1 >= maxStamp) {
    return true;
  } else {
    return false;
  }
}