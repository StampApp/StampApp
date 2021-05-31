class IsInt {
  bool _b; // 使用済みフラグ
  int _ib; // 使用済みフラグの返り値
  IsInt(bool b) {
    this._b = b;
    this._ib = b == true ? 0 : 1;
  }
  // Getter
  bool get b => _b;
  int get ib => _ib;
}
