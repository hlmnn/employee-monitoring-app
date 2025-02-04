import 'package:employee_monitoring_app/data/model/user_model.dart';

class DummyTaskModel {
  final String title;
  final UserModel member;
  final String cash;
  final String exp;
  final String startDate;
  final String lastDate;
  final String status;

  DummyTaskModel(this.title, this.member, this.cash, this.exp, this.startDate, this.lastDate, this.status);
}

List<DummyTaskModel> tasks = [
  DummyTaskModel(
    'Buat Laporan Hasil Rapat',
    UserModel(11,'John Doe Hidayat', 'Member', '17'),
    '150',
    '50',
    '20 Desember 2024',
    '28 Desember 2024',
    'active',
  ),
  DummyTaskModel(
    'Buat Laporan Hasil Rapat',
    UserModel(4,'Zendaya', 'Member', '10'),
    '150',
    '50',
    '20 Desember 2024',
    '30 Desember 2024',
    'complete',
  ),
  DummyTaskModel(
    'Buat Laporan Pertanggungjawaban',
    UserModel(6,'Sigma', 'Member', '8'),
    '150',
    '50',
    '20 Desember 2024',
    '24 Desember 2024',
    'complete',
  ),
  DummyTaskModel(
    'Buat Laporan Hasil Rapat',
    UserModel(4,'Zendaya', 'Member', '10'),
    '150',
    '50',
    '21 Desember 2024',
    '31 Desember 2024',
    'active',
  ),
  DummyTaskModel(
    'Buat Daftar Absen Workshop',
    UserModel(11,'John Doe Hidayat', 'Member', '17'),
    '150',
    '50',
    '26 Desember 2024',
    '29 Desember 2024',
    'active',
  ),
  DummyTaskModel(
    'Buat Laporan Hasil Workshop',
    UserModel(11,'John Doe Hidayat', 'Member', '17'),
    '150',
    '50',
    '30 Desember 2024',
    '31 Desember 2024',
    'active',
  ),
  DummyTaskModel(
    'Buat Laporan Pertanggungjawaban',
    UserModel(2,'David', 'Member', '12'),
    '150',
    '50',
    '20 Desember 2024',
    '22 Desember 2024',
    'active',
  ),
  DummyTaskModel(
    'Buat Laporan Kegiatan',
    UserModel(7,'Chad', 'Member', '15'),
    '150',
    '50',
    '20 Desember 2024',
    '31 Desember 2024',
    'complete',
  ),
  DummyTaskModel(
    'Buat Laporan Kegiatan',
    UserModel(5,'Broski', 'Member', '22'),
    '150',
    '50',
    '20 Desember 2024',
    '23 Desember 2024',
    'active',
  ),
];

class TaskModel {
  int id;
  String title;
  String description;
  int reward;
  int experience;
  DateTime startDate;
  DateTime dueDate;
  int groupId;
  String assignedBy;
  bool isActive;
  String resultReport;
  String resultFile;
  UserCardModel? member;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.reward,
    required this.experience,
    required this.startDate,
    required this.dueDate,
    required this.groupId,
    required this.assignedBy,
    required this.isActive,
    required this.resultReport,
    required this.resultFile,
    this.member,
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
      member: json['assigned_to'] != null
          ? UserCardModel.fromJson(json['assigned_to'])
          : null,
      assignedBy: json['assigned_by'],
      isActive: json['is_active'],
      resultReport: json['result_report'] ?? '',
      resultFile: json['result_file'] ?? '',
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
      member: json['assigned_to'] != null
          ? UserCardModel.fromJson(json['assigned_to'])
          : null,
    );
  }
}