class UserId {
  final int id;
  final String value;

  const UserId({
    required this.id,
    required this.value,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['id'],
      value: json['value'],
    );
  }
}
