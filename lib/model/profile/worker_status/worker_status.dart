class WorkerStatus {
  final int id;
  final String value;
  final String color;

  const WorkerStatus({
    required this.id,
    required this.value,
    required this.color,
  });

  factory WorkerStatus.fromJson(Map<String, dynamic> json) {
    return WorkerStatus(
      id: json['id'],
      value: json['value'],
      color: json['color'],
    );
  }
}
