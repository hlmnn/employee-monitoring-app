import 'package:employee_monitoring_app/ui/screen/monitor/monitor_member_list_page.dart';

class TaskModel {
  final String title;
  final Member member;
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
    Member(11,'John Doe Hidayat', 'Member', '17'),
    '150',
    '50',
    '20 Desember 2024',
    '28 Desember 2024',
    'active',
  ),
  TaskModel(
    'Buat Laporan Hasil Rapat',
    Member(4,'Zendaya', 'Member', '10'),
    '150',
    '50',
    '20 Desember 2024',
    '30 Desember 2024',
    'complete',
  ),
  TaskModel(
    'Buat Laporan Pertanggungjawaban',
    Member(6,'Sigma', 'Member', '8'),
    '150',
    '50',
    '20 Desember 2024',
    '24 Desember 2024',
    'complete',
  ),
  TaskModel(
    'Buat Laporan Pertanggungjawaban',
    Member(2,'David', 'Member', '12'),
    '150',
    '50',
    '20 Desember 2024',
    '22 Desember 2024',
    'active',
  ),
  TaskModel(
    'Buat Laporan Kegiatan',
    Member(7,'Chad', 'Member', '15'),
    '150',
    '50',
    '20 Desember 2024',
    '31 Desember 2024',
    'complete',
  ),
  TaskModel(
    'Buat Laporan Kegiatan',
    Member(5,'Broski', 'Member', '22'),
    '150',
    '50',
    '20 Desember 2024',
    '23 Desember 2024',
    'active',
  ),
];