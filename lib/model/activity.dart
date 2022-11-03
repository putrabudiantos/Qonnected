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
      location_checkin,
      longitude_checkin,
      latitude_checkin,
      location_checkout,
      longitude_checkout,
      latitude_checkout,
      category,
      time_in,
      time_out,
      name,
      date;
  final bool? deleted, checkin, checkout;
  final int? id;
  ActivityModel(
      {required this.id,
      required this.created_at,
      required this.profile_id,
      required this.description,
      required this.checkin,
      required this.checkout,
      required this.location_checkin,
      required this.longitude_checkin,
      required this.latitude_checkin,
      required this.location_checkout,
      required this.longitude_checkout,
      required this.latitude_checkout,
      required this.category,
      required this.deleted,
      required this.time_in,
      required this.time_out,
      required this.name,
      required this.date});

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      created_at: json['created_at'].toString(),
      profile_id: json['profile_id'] ?? '-',
      description: json['description'] ?? '-',
      checkin: json['checkin'] ?? false,
      checkout: json['checkout'] ?? false,
      location_checkin: json['location_checkin'].toString(),
      longitude_checkin: json['longitude_checkin'].toString(),
      latitude_checkin: json['latitude_checkin'].toString(),
      location_checkout: json['location_checkout'].toString(),
      longitude_checkout: json['longitude_checkout'].toString(),
      latitude_checkout: json['latitude_checkout'].toString(),
      category: json['category'] ?? '-',
      deleted: json['deleted'],
      name: json['profiles']['fullname'] ?? '-',
      time_in: json['checkin_time'],
      time_out: json['checkout_time'],
      date: json['date'].toString(),
    );
  }
}
