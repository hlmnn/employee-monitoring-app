import 'package:employee_monitoring_app/component/em_alert_dialog/em_create_server_dialog.dart';
import 'package:employee_monitoring_app/component/em_error.dart';
import 'package:flutter/material.dart';

class MonitorHomeCompletedTaskPage extends StatefulWidget {
  const MonitorHomeCompletedTaskPage({super.key, required this.title});

  final String title;

  @override
  _MonitorHomeCompletedTaskPageState createState() => _MonitorHomeCompletedTaskPageState();
}

class _MonitorHomeCompletedTaskPageState extends State<MonitorHomeCompletedTaskPage> {
  final List<String> tasks = [];

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
              // return EmCardTask(
              //   onTap: () {},
              //   title: 'Judul Task Selesai yang ke-${index + 1}',
              //   image: 'assets/images/avatar_placeholder.png',
              //   name: 'John Doe Hidayat',
              //   date: '7 Januari 2024',
              //   cash: '150',
              //   experience: '50',
              // );
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