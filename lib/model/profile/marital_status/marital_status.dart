class MaritalStatus {
  final int id;
  final String value;
  final String color;

  const MaritalStatus({
    required this.id,
    required this.value,
    required this.color,
  });

  factory MaritalStatus.fromJson(Map<String, dynamic> json) {
    return MaritalStatus(
      id: json['id'],
      value: json['value'],
      color: json['color'],
    );
  }
}
