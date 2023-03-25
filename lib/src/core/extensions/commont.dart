extension DoubleMapping on double {
  /// Return as number as formatted in thousands string.
  /// Example: -123456.asThousands() returns -123'456
  String asThousands({
    final String separator = "'",
    final int digits = 3,
  }) {
    assert(digits >= 1, '5d40ef0f-f8b4-4070-adf4-bbfc1a8b663b');
    final chars = abs().truncate().toString().split('').reversed;
    var n = 0;
    var result = '';
    for (final ch in chars) {
      if (n == digits) {
        result = '$ch$separator$result';
        n = 1;
      } else {
        result = '$ch$result';
        n++;
      }
    }
    result = this < 0 ? '-$result' : result;
    result = (this is double)
        ? '$result${toString().substring(toString().lastIndexOf('.'))}'
        : result;
    return result;
  }
}
