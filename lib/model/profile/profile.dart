import 'package:qonnected_app/model/profile/company_group_id/company_group_id.dart';
import 'package:qonnected_app/model/profile/marital_status/marital_status.dart';
import 'package:qonnected_app/model/profile/position/position.dart';
import 'package:qonnected_app/model/profile/user_id/user_id.dart';
import 'package:qonnected_app/model/profile/worker_status/worker_status.dart';

class ProfileModel {
  final String? id,
      order,
      uuid,
      fullname,
      email,
      date_of_birth,
      date_joined,
      phone,
      nik,
      nip,
      place_of_birth,
      religion,
      bank_account_number,
      npwp,
      address,
      instagram,
      linkedin,
      portofolio_url,
      tiktok,
      gender;
  bool deleted;
  WorkerStatus worker_status;
  Position position;
  UserId user_id;
  CompanyGroupId company_group_id;
  MaritalStatus marital_status;

  ProfileModel({
    this.gender,
    this.order,
    this.uuid,
    this.nik,
    this.nip,
    required this.deleted,
    required this.company_group_id,
    this.place_of_birth,
    this.religion,
    this.bank_account_number,
    required this.marital_status,
    this.npwp,
    this.address,
    this.instagram,
    this.linkedin,
    this.portofolio_url,
    this.tiktok,
    this.id,
    this.fullname,
    this.email,
    this.date_of_birth,
    this.date_joined,
    this.phone,
    required this.worker_status,
    required this.position,
    required this.user_id,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        id: json['id'].toString(),
        order: json['order'].toString(),
        uuid: json['uuid'].toString(),
        fullname: json['fullname'].toString(),
        email: json['email'].toString(),
        date_of_birth: json['date_of_birth'].toString(),
        date_joined: json['date_joined'].toString(),
        phone: json['phone'].toString(),
        position: json['position'] != null
            ? Position.fromJson(json['position'])
            : json['position'],
        worker_status: json['worker_status'] != null
            ? WorkerStatus.fromJson(json['worker_status'])
            : json['worker_status'],
        user_id: json['user_id'][0] != null
            ? UserId.fromJson(json['user_id'][0])
            : json['user_id'][0],
        nik: json['nik'].toString(),
        nip: json['nip'].toString(),
        company_group_id: json['company_group_id'][0] != null
            ? CompanyGroupId.fromJson(json['company_group_id'][0])
            : json['company_group_id'][0],
        place_of_birth: json['place_of_birth'].toString(),
        religion: json['religion'].toString(),
        bank_account_number: json['bank_account_number'].toString(),
        marital_status: json['marital_status'] != null
            ? MaritalStatus.fromJson(json['marital_status'])
            : json['marital_status'],
        npwp: json['npwp'].toString(),
        address: json['address'].toString(),
        instagram: json['instagram'].toString(),
        linkedin: json['linkedin'].toString(),
        portofolio_url: json['portofolio'].toString(),
        tiktok: json['tiktok'].toString(),
        gender: json['gender'].toString(),
        deleted: json['deleted']);
  }

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       // "username": username,
  //       // "avatar_url": avatar_url,
  //       "fullname": fullname,
  //       "email": email,
  //       "date_of_birth": date_of_birth,
  //       // "registration_id": registration_id,
  //       "date_joined": date_joined,
  //       "phone": phone,
  //       // "deleted": deleted,
  //       // "company_id": company_id,
  //       // "position": position,
  //       // "worker_status": worker_status,
  //       // "employee_identification": employee_identification,
  //       // "identity_number": identity_number,
  //       // "user_id": user_id,
  //       "nik": nik,
  //       "nip": nip,
  //       // "company_group_id": company_group_id,
  //       "place_of_birth": place_of_birth,
  //       "religion": religion,
  //       "bank_account_number": bank_account_number,
  //       // "marital_status": marital_status,
  //       "npwp": npwp,
  //       // "activities": activities,
  //       "address": address,
  //       "instagram": instagram,
  //       "portofolio_url": portofolio_url,
  //       "tiktok": tiktok,
  //       "gender": gender,
  //       // "company_name": company_name
  //     };
}
