import 'package:employee_monitoring_app/data/model/user_model.dart';

class TaskModel {
  final String title;
  final UserModel member;
  final String cash;
  final String exp;
  final String startDate;
  final String lastDate;
  final String status;

  TaskModel(this.title, this.member, this.cash, this.exp, this.startDate, this.lastDate, this.status);
}

List<TaskModel> tasks = [
  TaskModel(
    'Buat Laporan Hasil Rapat',
    UserModel(11,'John Doe Hidayat', 'Member', '17'),
    '150',
    '50',
    '20 Desember 2024',
    '28 Desember 2024',
    'active',
  ),
  TaskModel(
    'Buat Laporan Hasil Rapat',
    UserModel(4,'Zendaya', 'Member', '10'),
    '150',
    '50',
    '20 Desember 2024',
    '30 Desember 2024',
    'complete',
  ),
  TaskModel(
    'Buat Laporan Pertanggungjawaban',
    UserModel(6,'Sigma', 'Member', '8'),
    '150',
    '50',
    '20 Desember 2024',
    '24 Desember 2024',
    'complete',
  ),
  TaskModel(
    'Buat Laporan Pertanggungjawaban',
    UserModel(2,'David', 'Member', '12'),
    '150',
    '50',
    '20 Desember 2024',
    '22 Desember 2024',
    'active',
  ),
  TaskModel(
    'Buat Laporan Kegiatan',
    UserModel(7,'Chad', 'Member', '15'),
    '150',
    '50',
    '20 Desember 2024',
    '31 Desember 2024',
    'complete',
  ),
  TaskModel(
    'Buat Laporan Kegiatan',
    UserModel(5,'Broski', 'Member', '22'),
    '150',
    '50',
    '20 Desember 2024',
    '23 Desember 2024',
    'active',
  ),
];