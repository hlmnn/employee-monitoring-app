import 'package:employee_monitoring_app/data/model/user_model.dart';

class TaskModel {
  int id;
  String title;
  String description;
  int reward;
  int experience;
  DateTime startDate;
  DateTime dueDate;
  int groupId;
  String assignedTo;
  String assignedBy;
  bool isActive;
  String resultReport;
  String resultFile;
  UserCardModel? memberCard;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.reward,
    required this.experience,
    required this.startDate,
    required this.dueDate,
    required this.groupId,
    required this.assignedTo,
    required this.assignedBy,
    required this.isActive,
    required this.resultReport,
    required this.resultFile,
    this.memberCard,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      reward: json['reward'],
      experience: json['experience'],
      startDate: DateTime.parse(json['start_date']),
      dueDate: DateTime.parse(json['due_date']),
      groupId: json['group_id'],
      assignedTo: json['assigned_to'],
      assignedBy: json['assigned_by'],
      isActive: json['is_active'],
      resultReport: json['result_report'] ?? '',
      resultFile: json['result_file'] ?? '',
      memberCard: json['member'] != null ? UserCardModel.fromJson(json['member']) : null,
    );
  }
}

class TaskCardModel {
  int id;
  String title;
  int reward;
  int experience;
  DateTime dueDate;
  UserCardModel? member;

  TaskCardModel({
    required this.id,
    required this.title,
    required this.reward,
    required this.experience,
    required this.dueDate,
    this.member,
  });

  factory TaskCardModel.fromJson(Map<String, dynamic> json) {
    return TaskCardModel(
      id: json['id'],
      title: json['title'],
      reward: json['reward'],
      experience: json['experience'],
      dueDate: DateTime.parse(json['due_date']),
      member: json['assigned_to'] != null ? UserCardModel.fromJson(json['assigned_to']) : null,
    );
  }
}