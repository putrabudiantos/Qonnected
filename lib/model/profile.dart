import 'dart:convert';

// List<ProfileModel> ProfileModelFromJson(String str) => List<ProfileModel>.from(
//     json.decode(str).map((x) => ProfileModel.fromJson(x)));

// String ProfileModelToJson(List<ProfileModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileModel {
  @override
  final String? id,
      username,
      avatar_url,
      fullname,
      email,
      date_of_birth,
      registration_id,
      date_joined,
      phone,
      position,
      worker_status;
  final bool? deleted;
  final int company_id;

  ProfileModel(
      {required this.id,
      required this.username,
      required this.avatar_url,
      required this.fullname,
      required this.email,
      required this.date_of_birth,
      required this.registration_id,
      required this.date_joined,
      required this.phone,
      required this.deleted,
      required this.position,
      required this.company_id,
      required this.worker_status});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        id: json['id'],
        username: json['username'] ?? '-',
        avatar_url: json['avatar_url'] ?? '-',
        fullname: json['fullname'] ?? '-',
        email: json['email'] ?? '-',
        date_of_birth: json['date_of_birth'] ?? '-',
        registration_id: json['registration_id'] ?? '-',
        date_joined: json['date_joined'] ?? '-',
        phone: json['phone'] ?? '-',
        deleted: json['deleted'],
        position: json['position'] ?? '-',
        company_id: json['company_group_id'],
        worker_status: json['worker_status'] ?? '-');
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "avatar_url": avatar_url,
        "fullname": fullname,
        "email": email,
        "date_of_birth": date_of_birth,
        "registration_id": registration_id,
        "date_joined": date_joined,
        "phone": phone,
        "deleted": deleted,
        "company_id": company_id,
        "position": position,
        "worker_status": worker_status
      };
}
