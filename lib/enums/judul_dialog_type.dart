enum JudulDialogType {
  details(0),
  initialDeteksi(1),
  hasilDeteksi(2);

  final int value;

  const JudulDialogType(this.value);

  bool get isDetails => value == 0;
  bool get isInitialDeteksi => value == 1;
  bool get isHasilDeteksi => value == 2;
}
