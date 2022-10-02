enum JudulDialogType {
  details(0),
  initialDeteksi(1),
  hasilDeteksi(2),
  tolak(3),
  terima(4);

  final int value;

  const JudulDialogType(this.value);

  bool get isDetails => value == 0;
  bool get isInitialDeteksi => value == 1;
  bool get isHasilDeteksi => value == 2;
  bool get isTolak => value == 3;
  bool get isTerima => value == 4;
}
