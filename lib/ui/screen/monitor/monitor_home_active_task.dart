import 'package:employee_monitoring_app/component/em_alert_dialog/em_create_server_dialog.dart';
import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/component/em_error.dart';
import 'package:employee_monitoring_app/data/model/task_model.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/monitor_member_list_page.dart';
import 'package:flutter/material.dart';

class MonitorHomeActiveTaskPage extends StatefulWidget {
  const MonitorHomeActiveTaskPage({super.key, required this.title});

  final String title;

  @override
  _MonitorHomeActiveTaskPageState createState() => _MonitorHomeActiveTaskPageState();
}

class _MonitorHomeActiveTaskPageState extends State<MonitorHomeActiveTaskPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: tasks.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return EmCard.task(
                    onTap: (){},
                    image: 'assets/images/avatar_placeholder.png',
                    title: '${tasks[index].title} yang ke-${index + 1}',
                    name: tasks[index].member.name,
                    level: tasks[index].member.level,
                    date: tasks[index].lastDate,
                    cash: tasks[index].cash,
                    experience: tasks[index].exp,
                  );
                },
              )
            : EmError(
              onPressed: (){
                EmCreateServerDialog.show(context,
                  onConfirm: (){},
                  title: 'Buat Server',
                  content: 'Tulis nama server sesuai yang Anda inginkan',
                );
              },
              textAbove: 'Anda belum mempunyai server.',
              textBelow: 'Buat server terlebih dahulu!',
            ),
      ),
    );
  }
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