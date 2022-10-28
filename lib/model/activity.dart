import 'dart:convert';

// List<ProfileModel> ProfileModelFromJson(String str) => List<ProfileModel>.from(
//     json.decode(str).map((x) => ProfileModel.fromJson(x)));

// String ProfileModelToJson(List<ProfileModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityModel {
  @override
  final String? created_at,
      profile_id,
      description,
      type,
      location,
      longitude,
      latitude,
      category,
      date;
  final bool? deleted;
  final int? id;
  ActivityModel(
      {required this.id,
      required this.created_at,
      required this.profile_id,
      required this.description,
      required this.type,
      required this.location,
      required this.longitude,
      required this.latitude,
      required this.category,
      required this.deleted,
      required this.date});

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      created_at: json['created_at'].toString(),
      profile_id: json['profile_id'] ?? '-',
      description: json['description'] ?? '-',
      type: json['type'] ?? '-',
      location: json['location'].toString(),
      longitude: json['longitude'].toString(),
      latitude: json['latitude'].toString(),
      category: json['category'] ?? '-',
      deleted: json['deleted'],
      date: json['date'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": created_at,
        "profile_id": profile_id,
        "description": description,
        "type": type,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "category": category,
        "deleted": deleted,
        "date": date,
      };
}
