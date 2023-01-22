enum ListDetailType {
  text(0),
  chip(1),
  circle(2);

  final int value;

  const ListDetailType(this.value);

  bool get isText => this == ListDetailType.text;
  bool get isChip => this == ListDetailType.chip;
  bool get isCircle => this == ListDetailType.circle;
}
