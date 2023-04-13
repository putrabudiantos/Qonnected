class Position {
  final int id;
  final String value;
  final String color;

  const Position({
    required this.id,
    required this.value,
    required this.color,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id'],
      value: json['value'],
      color: json['color'],
    );
  }
}
