import 'package:employee_monitoring_app/component/em_alert_dialog/em_create_group_dialog.dart';
import 'package:employee_monitoring_app/component/em_card/em_card.dart';
import 'package:employee_monitoring_app/component/em_error.dart';
import 'package:employee_monitoring_app/data/model/task_model.dart';
import 'package:employee_monitoring_app/ui/screen/monitor/task/monitor_task_detail_page.dart';
import 'package:flutter/material.dart';

class MonitorHomeActiveTaskPage extends StatefulWidget {
  const MonitorHomeActiveTaskPage({super.key, required this.title, required this.isJoinServer});

  final String title;
  final bool isJoinServer;

  @override
  _MonitorHomeActiveTaskPageState createState() => _MonitorHomeActiveTaskPageState();
}

class _MonitorHomeActiveTaskPageState extends State<MonitorHomeActiveTaskPage> {

  @override
  Widget build(BuildContext context) {
    return widget.isJoinServer == true
      ? tasks.any((task) => task.status == 'active')
        ? ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.vertical,
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            if (tasks[index].status != 'active') return const SizedBox.shrink();
            return EmCard.task(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MonitorTaskDetailPage(title: 'Detail Tugas'),
                  ),
                );
              },
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
          onPressed: () {},
          textAbove: 'Anda belum mempunyai tugas.',
          textBelow: 'Buat tugas terlebih dahulu!',
        )
    : EmError(
      onPressed: () {
        EmCreateGroupDialog.show(
          context,
          title: 'Buat Grup',
          content: 'Tulis nama grup sesuai yang Anda inginkan',
        );
      },
      textAbove: 'Anda belum mempunyai grup.',
      textBelow: 'Buat grup terlebih dahulu!',
      isButton: true,
    );
  }
}