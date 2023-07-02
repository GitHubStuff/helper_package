extension StringExtensions on String {
  String lastCharacters(int n) {
    assert(n > 1);
    return (n >= length) ? this : substring(length - n);
  }

  DateTime toDate() => DateTime.parse(this);
}
