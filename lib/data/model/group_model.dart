import 'package:employee_monitoring_app/data/model/user_model.dart';

class GroupModel {
  int id;
  String name;
  String groupCode;
  int memberCount;
  List<AuthUserModel>? members;

  GroupModel({
    required this.id,
    required this.name,
    required this.groupCode,
    this.memberCount = 0,
    this.members
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'],
      groupCode: json['group_code'],
      members: json['members'] != null
        ? (json['members'] as List).map((e) => AuthUserModel.fromJson(e)).toList()
        : null,
    );
  }
}