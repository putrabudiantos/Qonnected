class CompanyGroupId {
  final int id;
  final String value;

  const CompanyGroupId({
    required this.id,
    required this.value,
  });

  factory CompanyGroupId.fromJson(Map<String, dynamic> json) {
    return CompanyGroupId(
      id: json['id'],
      value: json['value'],
    );
  }
}
