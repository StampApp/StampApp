class IsInt {
  bool b; // 使用済みフラグ
  int ib; // 使用済みフラグの返り値
  IsInt(this.b) {
    this.ib = b == true ? 0 : 1;
  }
}
