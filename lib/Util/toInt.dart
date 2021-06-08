int toInt(bool deletedFlg) {
  if (deletedFlg) {
    return 0;
  } else if (!deletedFlg) {
    return 1;
  }
}
