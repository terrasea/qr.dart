part of bot_qr;

class QrMath {
  static List<int> __logTable;
  static List<int> __expTable;

  static List<int> getZeroedList(int count) => new List.filled(count, 0);

  static glog(n) {

    if (n < 1) {
      throw 'glog($n)';
    }

    return _logTable[n];
  }

  static int gexp(n) {

    while (n < 0) {
      n += 255;
    }

    while (n >= 256) {
      n -= 255;
    }

    return _expTable[n];
  }

  static List<int> get _expTable {
    if(__expTable == null) {
      var t = QrMath.getZeroedList(256);
      for (int i = 0; i < 8; i++) {
        t[i] = 1 << i;
      }
      for (int i = 8; i < 256; i++) {
        t[i] = t[i - 4] ^ t[i - 5] ^ t[i - 6] ^ t[i - 8];
      }
      __expTable = t;
    }
    return __expTable;
  }

  static List<int> get _logTable {
    if(__logTable == null) {
      var t = QrMath.getZeroedList(256);
      // this was the code I had in pl
      // only to 255? seems really weird
      for (int i = 0; i < 255; i++) {
        t[_expTable[i]] = i;
      }
      __logTable = t;
    }
    return __logTable;
  }
}
