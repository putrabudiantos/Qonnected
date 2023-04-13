import 'package:qonnected_app/model/profile/profile.dart';

class CoWorkersModel {
  late final String? count, next, previous;
  ProfileModel results;

  CoWorkersModel({this.count, this.next, this.previous, required this.results});

  factory CoWorkersModel.fromJson(Map<String, dynamic> json) {
    return CoWorkersModel(
        count: json['count'].toString(),
        next: json['next'].toString(),
        previous: json['previous'].toString(),
        results: json['results'][0] != null
            ? ProfileModel.fromJson(json['results'][0])
            : json['results'][0]);
  }
}
